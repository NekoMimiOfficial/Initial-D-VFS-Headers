#ifndef __IDSS_ANA_EXT
#define __IDSS_ANA_EXT

#include "ANA.hpp"
#include <string>

class Extractor
{
  private:
    std::string filename;

  public:
    Extractor(std::string fn);
    ANA extract();
};

#endif // !__IDSS_ANA_EXT
