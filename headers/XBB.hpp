#ifndef __IDSS_XBB
#define __IDSS_XBB

#include <cstddef>
#include <cstdint>
#include <string>
#include <vector>

struct XBBitem
{
  uint32_t ptr_start;
  uint32_t ptr_size;
  uint32_t ptr_name;
  uint32_t crc;

  size_t index;

  std::string filename;
  std::vector<uint8_t> data;
};

struct XBB
{
  uint8_t flag_4;
  size_t file_count;
  bool valid= true;

  std::vector<XBBitem> items;
};

#endif // !__IDSS_XBB
