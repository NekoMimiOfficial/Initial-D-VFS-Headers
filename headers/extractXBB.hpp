#ifndef __IDSS_XBB_EXT
#define __IDSS_XBB_EXT

#include "XBB.hpp"
#include <string>

class Extractor
{
  private:
    std::string filename;

  Extractor(std::string filename);

  XBB extract();
};

#endif // !__IDSS_XBB_EXT
