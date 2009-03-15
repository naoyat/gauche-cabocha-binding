/*
 * cabocha.h
 *
 *  2009.3.15 by naoya_t
 *
 */

/* Prologue */
#ifndef GAUCHE_CABOCHA_H
#define GAUCHE_CABOCHA_H

#include <gauche.h>
#include <gauche/extend.h>

SCM_DECL_BEGIN

/* CaboCha_t wrapper */
typedef struct ScmCaboChaRec {
  SCM_HEADER;
  cabocha_t *c; /* NULL if closed */
} ScmCaboCha;
SCM_CLASS_DECL(Scm_CaboChaClass);
#define SCM_CLASS_CABOCHA       (&Scm_CaboChaClass)
#define SCM_CABOCHA(obj)        ((ScmCaboCha*)(obj))
#define SCM_CABOCHAP(obj)       (SCM_XTYPEP(obj, SCM_CLASS_CABOCHA))
extern cabocha_t* unwrap_cabocha_t(ScmObj obj);
extern ScmObj wrap_cabocha_t(cabocha_t *m);

/* APIs with (int argc, char **argv) */
typedef cabocha_t *(*cabocha_func_with_args)(int argc, char **argv);
typedef int (*int_func_with_args)(int argc, char **argv);
extern cabocha_t *cabocha_call_cabocha_func(cabocha_func_with_args fn, ScmObj args);
extern int cabocha_call_int_func(int_func_with_args fn, ScmObj args);

/* Epilogue */
SCM_DECL_END

#endif  /* GAUCHE_CABOCHA_H */
