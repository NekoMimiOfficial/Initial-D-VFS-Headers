#ifndef __IDSS_XBB_EXT
#define __IDSS_XBB_EXT

#include "XBB.hpp"
#include <string>

class XBBExtractor
{
  private:
    std::string filename;

  public:
    XBBExtractor(std::string fn);
    XBB extract();
};

#endif // !__IDSS_XBB_EXT
