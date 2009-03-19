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

/* cabocha_t wrapper */
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

/* cabocha_tree_t wrapper */
typedef struct ScmCaboChaTreeRec {
  SCM_HEADER;
  cabocha_tree_t *ctree; /* NULL if closed */
} ScmCaboChaTree;
SCM_CLASS_DECL(Scm_CaboChaTreeClass);
#define SCM_CLASS_CABOCHA_TREE       (&Scm_CaboChaTreeClass)
#define SCM_CABOCHA_TREE(obj)        ((ScmCaboChaTree*)(obj))
#define SCM_CABOCHA_TREEP(obj)       (SCM_XTYPEP(obj, SCM_CLASS_CABOCHA_TREE))
extern cabocha_tree_t* unwrap_cabocha_tree_t(ScmObj obj);
extern ScmObj wrap_cabocha_tree_t(cabocha_tree_t *m);

/* cabocha_chunk_t wrapper */
typedef struct ScmCaboChaChunkRec {
  SCM_HEADER;
  cabocha_chunk_t *cchunk; /* NULL if closed */
} ScmCaboChaChunk;
SCM_CLASS_DECL(Scm_CaboChaChunkClass);
#define SCM_CLASS_CABOCHA_CHUNK       (&Scm_CaboChaChunkClass)
#define SCM_CABOCHA_CHUNK(obj)        ((ScmCaboChaChunk*)(obj))
#define SCM_CABOCHA_CHUNKP(obj)       (SCM_XTYPEP(obj, SCM_CLASS_CABOCHA_CHUNK))
extern cabocha_chunk_t* unwrap_cabocha_chunk_t(ScmObj obj);
extern ScmObj wrap_cabocha_chunk_t(cabocha_chunk_t *m);

/* cabocha_token_t wrapper */
typedef struct ScmCaboChaTokenRec {
  SCM_HEADER;
  cabocha_token_t *ctok; /* NULL if closed */
} ScmCaboChaToken;
SCM_CLASS_DECL(Scm_CaboChaTokenClass);
#define SCM_CLASS_CABOCHA_TOKEN       (&Scm_CaboChaTokenClass)
#define SCM_CABOCHA_TOKEN(obj)        ((ScmCaboChaToken*)(obj))
#define SCM_CABOCHA_TOKENP(obj)       (SCM_XTYPEP(obj, SCM_CLASS_CABOCHA_TOKEN))
extern cabocha_token_t* unwrap_cabocha_token_t(ScmObj obj);
extern ScmObj wrap_cabocha_token_t(cabocha_token_t *m);


/* APIs with (int argc, char **argv) */
typedef cabocha_t *(*cabocha_func_with_args)(int argc, char **argv);
// typedef int (*int_func_with_args)(int argc, char **argv);
extern cabocha_t *cabocha_call_cabocha_func(cabocha_func_with_args fn, ScmObj args);
extern int cabocha_call_int_func(int_func_with_args fn, ScmObj args);

/* Epilogue */
SCM_DECL_END

#endif  /* GAUCHE_CABOCHA_H */
