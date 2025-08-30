#ifndef __IDSS_TYPECHECK
#define __IDSS_TYPECHECK

#include <string>

enum VFSType {
  XBB= 0,
  ANA,
  ERR
};

VFSType checkVFS(std::string filename);

#endif // __IDSS_TYPECHECK
