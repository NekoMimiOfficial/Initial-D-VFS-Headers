#ifndef __IDSS_XBB
#define __IDSS_XBB

#include <cstddef>
#include <cstdint>
#include <vector>

struct XBB
{
  uint32_t ptr_start;
  uint32_t ptr_size;
  uint32_t ptr_name;
  uint32_t crc;

  size_t index;

  std::vector<uint8_t> data;
};

#endif // !__IDSS_XBB
