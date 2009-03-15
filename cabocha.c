/*
 * cabocha.c
 *
 *  2009.3.15 by naoya_t
 *
 */

#include <gauche.h>
#include <gauche/extend.h>

#include <cabocha.h>
#include "cabocha.h"

// cabocha_t
cabocha_t* unwrap_cabocha_t(ScmObj obj)
{
  return SCM_CABOCHA(obj)->c;
}
ScmObj wrap_cabocha_t(cabocha_t *c)
{
  ScmCaboCha *obj = SCM_NEW(ScmCaboCha);
  SCM_SET_CLASS(obj, SCM_CLASS_CABOCHA);
  obj->c = c;
  return SCM_OBJ(obj);
}


/* APIs with (int argc, char **argv) */
#define cabocha_call_func(result_type,fn,args) do{  \
  result_type result;         \
  if (SCM_NULLP(args)) {      \
    char *argv[] = {""};      \
    result = (fn)(1,argv);    \
  } else {                    \
    int argc, i=0;              \
    ScmObj argl;                \
    char **argv = NULL;         \
    if (SCM_INTEGERP(Scm_Car(args))) {                              \
      argc = SCM_INT_VALUE(Scm_Car(args)); argl = Scm_Cadr(args);   \
    } else {                                                        \
      argc = 1 + Scm_Length(args); i++; argl = args;                \
    }                                                               \
    argv = (char**)malloc(sizeof(char*) * argc);                    \
    if (i) argv[0] = "";                                                \
    if (argv) {                                                         \
      if (SCM_VECTORP(argl)) {                                          \
        for (;i<argc;i++)                                        \
          argv[i] = (char *)Scm_GetStringConst((ScmString *)SCM_VECTOR_ELEMENT(argl,i)); \
      } else {                                                          \
        for (;i<argc && !SCM_NULLP(argl); argl=Scm_Cdr(argl),i++) \
          argv[i] = (char *)Scm_GetStringConst((ScmString *)Scm_Car(argl)); \
      }                                                                 \
      result = (fn)(argc,argv);                                         \
    }                                                                   \
    free((void *)argv);                                                 \
  }                                                                     \
  return result;                                                        \
} while(0)

cabocha_t *cabocha_call_cabocha_func(cabocha_func_with_args fn, ScmObj args)
{
  cabocha_call_func(cabocha_t*,fn,args);
}
int cabocha_call_int_func(int_func_with_args fn, ScmObj args)
{
  cabocha_call_func(int,fn,args);
}

/*
 * Module initialization function.
 */
extern void Scm_Init_cabochalib(ScmModule*);

void Scm_Init_cabocha(void)
{
    ScmModule *mod;

    /* Register this DSO to Gauche */
    SCM_INIT_EXTENSION(cabocha);

    /* Create the module if it doesn't exist yet. */
    mod = SCM_MODULE(SCM_FIND_MODULE("cabocha", TRUE));

    /* Register stub-generated procedures */
    Scm_Init_cabochalib(mod);
}
