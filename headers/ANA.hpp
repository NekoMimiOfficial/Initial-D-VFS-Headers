#ifndef __IDSS_ANA
#define __IDSS_ANA

#include <cstddef>
#include <cstdint>
#include <string>
#include <vector>

struct ANAitem
{
  uint32_t ptr_start;
  uint32_t ptr_size;

  size_t index;

  std::string filename;
  std::vector<uint8_t> data;
};

struct ANA
{
  size_t file_count;
  bool valid= true;

  std::vector<ANAitem> items;
};

#endif // !__IDSS_ANA
