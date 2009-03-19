/*
 * mecab.h
 *
 *  2009.3.13 by naoya_t
 *
 */

/* Prologue */
#ifndef GAUCHE_MECAB_H
#define GAUCHE_MECAB_H

#include <gauche.h>
#include <gauche/extend.h>

SCM_DECL_BEGIN

/* mecab_t wrapper */
typedef struct ScmMeCabRec {
  SCM_HEADER;
  mecab_t *m; /* NULL if closed */
} ScmMeCab;
SCM_CLASS_DECL(Scm_MeCabClass);
#define SCM_CLASS_MECAB       (&Scm_MeCabClass)
#define SCM_MECAB(obj)        ((ScmMeCab*)(obj))
#define SCM_MECABP(obj)       (SCM_XTYPEP(obj, SCM_CLASS_MECAB))
extern mecab_t* unwrap_mecab_t(ScmObj obj);
extern ScmObj wrap_mecab_t(mecab_t *m);

/* mecab_node_t wrapper */
typedef struct ScmMeCabNodeRec {
  SCM_HEADER;
  const mecab_node_t *mn; /* NULL if closed */
} ScmMeCabNode;
SCM_CLASS_DECL(Scm_MeCabNodeClass);
#define SCM_CLASS_MECAB_NODE  (&Scm_MeCabNodeClass)
#define SCM_MECAB_NODE(obj)   ((ScmMeCabNode*)(obj))
#define SCM_MECAB_NODEP(obj)  (SCM_XTYPEP(obj, SCM_CLASS_MECAB_NODE))
extern const mecab_node_t* unwrap_mecab_node_t(ScmObj obj);
extern ScmObj wrap_mecab_node_t(const mecab_node_t *m);

/* mecab_dictionary_info_t wrapper */
typedef struct ScmMeCabDictionaryInfoRec {
  SCM_HEADER;
  const mecab_dictionary_info_t *mdi; /* NULL if closed */
} ScmMeCabDictionaryInfo;
SCM_CLASS_DECL(Scm_MeCabDictionaryInfoClass);
#define SCM_CLASS_MECAB_DICTIONARY_INFO  (&Scm_MeCabDictionaryInfoClass)
#define SCM_MECAB_DICTIONARY_INFO(obj)   ((ScmMeCabDictionaryInfo*)(obj))
#define SCM_MECAB_DICTIONARY_INFOP(obj)  (SCM_XTYPEP(obj, SCM_CLASS_MECAB_DICTIONARY_INFO))
extern const mecab_dictionary_info_t* unwrap_mecab_dictionary_info_t(ScmObj obj);
extern ScmObj wrap_mecab_dictionary_info_t(const mecab_dictionary_info_t *m);

/* APIs with (int argc, char **argv) */
typedef mecab_t *(*mecab_func_with_args)(int argc, char **argv);
typedef int (*int_func_with_args)(int argc, char **argv);
extern mecab_t *mecab_call_mecab_func(mecab_func_with_args fn, ScmObj args);
extern int mecab_call_int_func(int_func_with_args fn, ScmObj args);

/* Epilogue */
SCM_DECL_END

#endif  /* GAUCHE_MECAB_H */
