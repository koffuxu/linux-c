#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

void *thr_fn(void *arg)
{
        sleep(2);
        printf("thread  exiting\n");
        //pthread_exit((void *)3);
        return NULL;
}

int main(void)
{
    int            err;
    pthread_t   tid;
    void* tret;
    pthread_attr_t attr;

    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

    err = pthread_create(&tid, &attr, thr_fn, NULL);
    pthread_attr_destroy(&attr);

    if (err != 0)
        printf("can't create thread 1\n");

    err = pthread_join(tid, &tret);
    if (err != 0)
        printf("can't join with thread 1\n");

    printf("thread  exit code %d\n", err);
    return 0;
}
