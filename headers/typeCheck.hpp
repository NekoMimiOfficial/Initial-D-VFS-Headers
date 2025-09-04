#ifndef __IDSS_TYPECHECK
#define __IDSS_TYPECHECK

#include <string>

enum VFSType {
  XBB= 0,
  ANA= 1,
  ERR= 3
};

VFSType checkVFS(std::string filename);

#endif // __IDSS_TYPECHECK
