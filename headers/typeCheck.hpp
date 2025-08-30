#ifdef __IDSS_TYPECHECK
#define __IDSS_TYPECHECK

#include <string>

enum VFSType {
  XBB,
  ANA,
  ERR
};

VFSType checkVFS(std::string filename);

#endif // __IDSS_TYPECHECK
