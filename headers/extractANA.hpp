#ifndef __IDSS_ANA_EXT
#define __IDSS_ANA_EXT

#include "ANA.hpp"
#include <string>

class ANAExtractor
{
  private:
    std::string filename;

  public:
    ANAExtractor(std::string fn);
    ANA extract();
};

#endif // !__IDSS_ANA_EXT
