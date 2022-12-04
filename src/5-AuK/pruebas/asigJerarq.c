#include <stdio.h>
#include <unistd.h> /* usleep        */
#include <time.h>   /* time          */
#include <stdlib.h> /* srand, rand   */
#include <stdarg.h> /* variadic args */
#include <pthread.h>


static pthread_mutex_t screenx = PTHREAD_MUTEX_INITIALIZER;

int print_t(const char *format, ...) {
    int result, s;
    va_list args;
    va_start(args, format);
    s = pthread_mutex_lock(&screenx);
    if (s != 0) {
        printf("Error bloqueando el mutex.\n");
        return -1;
    }
    result = vprintf(format, args);
    fflush(stdout);
    s = pthread_mutex_unlock(&screenx);
    if (s != 0) {
        printf("Error desbloqueando el mutex.\n");
        return -2;
    }

    va_end(args);
    return result;
}



/* Solución 2: Asignación jerárquica 
 * Existe una jerarquía en los filósofos de forma que ninguno coma cuando
 * no le toque.
 */

#define NUM_FIL 5

struct timespec t_hambre;

typedef enum {
    VIVO   = 1,
    MUERTO = 0
} estado;


pthread_mutex_t tenedores[NUM_FIL];
estado filosofos[NUM_FIL] = {VIVO, VIVO, VIVO, VIVO, VIVO}; 
int hambre[NUM_FIL] = {0, 0, 0, 0, 0}; 
/* TODO: inicializar los dos vectores de arriba correctamente */

int lockMutex(pthread_mutex_t *restrict mutex) {
    struct timespec tout;
    int ret;
    clock_gettime(CLOCK_REALTIME, &tout);
    tout.tv_sec += 3;

    ret = pthread_mutex_timedlock(mutex, &tout);
    return ret;
}


void meditar(int id) {
    int micros, m;
    micros = (rand() % (9 - 1 + 1)) + 1; /* 1 - 9 */
    m = micros * 100000;
    print_t("[%d] Meditando durante 0.%d segundos\n", id, micros);
    usleep(m);
}

int maxhambre() {
    int max = 0;
    int i;
    for (i = 0; i < NUM_FIL; i++)
        if (hambre[i] > max)
            max = hambre[i];

    return max;
}

int puedoComer(int id) {
    int i;
    int mihambre  = hambre[id];
    int maxh      = maxhambre();
    int maxprio   = 0;

    /* No soy el más hambriento: no como */
    if (mihambre < maxh) {
        print_t("[%d] No soy el más hambriento [%d %d %d %d %d].\n", id,
                hambre[0], hambre[1], hambre[2], hambre[3], hambre[4]);
        return -1;
    }

    /* Entre todos los más hambrientos, busca al del mayor id */
    for (i = 0; i < NUM_FIL; i++) {
        if (hambre[i] == maxh)
            maxprio = i;
    }

    /* Soy de los más hambrientos, pero no el que más prioridad tiene */
    if (id != maxprio) {
        print_t("[%d] Max prio: %d.\n", id, maxprio);
        return -2;
    }
    /* Soy de los más hambrientos y el que más prioridad tiene */
    else {
        print_t("[%d] Tiene permiso para comer [%d %d %d %d %d].\n", id,
                hambre[0], hambre[1], hambre[2], hambre[3], hambre[4]);
        return 0;
    }
}


int cogerTenedores(int id) {
    int ten1, ten2;
    ten1 = id;
    ten2 = (id + 1) % NUM_FIL;

    if (pthread_mutex_trylock(&tenedores[ten1]) == 0) {
        if (pthread_mutex_trylock(&tenedores[ten2]) == 0) {
            // print_t("[%d] Ha cogido los tenedores %d y %d.\n", id, ten1, ten2);
        }
        else {
            // print_t("\t[%d] Tenedor %d ocupado.\n", id, ten2);
            pthread_mutex_unlock(&tenedores[ten1]);
            // print_t("\t[%d] Tenedor %d soltado.\n", id, ten1);
        }
    }
    else {
        // print_t("\t[%d] Tenedor %d ocupado.\n", id, ten1);
    }

    return 0;
}

void soltarTenedores(int id) {
    int ten1, ten2, r1, r2;
    ten1 = id;
    ten2 = (id + 1) % NUM_FIL;
    r1 = pthread_mutex_unlock(&tenedores[ten1]);
    r2 = pthread_mutex_unlock(&tenedores[ten2]);

    if (r1 != 0 || r2 != 0) {
        print_t("El filósofo %d no ha podido soltar los tenedores.\n", id);
    }
    else {
        // print_t("[%d] suelta los tenedores %d y %d.\n", id, ten1, ten2);
    }
}

void comer(int id) {
    int micros, m;
    micros = (rand() % (9 - 1 + 1)) + 1; /* 1 - 9 */
    m = micros * 1000000;
    if (puedoComer(id) == 0) {
        if (cogerTenedores(id) != 0) {
            return;
        }

        print_t("\t\t[%d] Come durante %d segundos.\n", id, micros);
        hambre[id] = 0;
        usleep(m);
        soltarTenedores(id);
        print_t("\t\t[%d] Termina de comer.\n", id);
    }
    else {
        hambre[id]++;
    }
}


void *filosofo(void *id) {
    int id_fil;
    id_fil = *((int *) id);
    free(id);
    // print_t("FILÓSOFO %d CREADO.\n", id_fil);
    while (filosofos[id_fil] == VIVO) {
        comer(id_fil);
        meditar(id_fil);
    }
    return NULL;
}

int main() {
    srand(time(NULL));
    int i;
    pthread_t filos[NUM_FIL];

    for (i = 0; i < NUM_FIL; i++) {
        if (pthread_mutex_init(&tenedores[i], 0) != 0) {
            print_t("Error inicializando tenedor %d.\n", i);
            return -1;
        }
    }

    for (i = 0; i < NUM_FIL; i++) {
        int *c = malloc(sizeof(int));
        *c = i;
        // print_t("Creando filósofo %d\n", *c);
        if (c == NULL) {
            printf("Error malloc\n");
            return -1;
        }

        if (pthread_create(&filos[i], NULL, filosofo, c)) {
            return -1;
        }
    }
    
    for (i = 0; i < NUM_FIL; i++) {
        pthread_join(filos[i], NULL);
    }


    return 0;
}
