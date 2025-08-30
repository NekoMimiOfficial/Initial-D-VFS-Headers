#ifndef __IDSS_HASHTOOLS
#define __IDSS_HASHTOOLS

#include <cstdint>

extern "C"
{
  uint32_t xor_u32(uint32_t a, uint32_t b);
  double sqrt_fast(double a);
  uint32_t asm_crc(uint32_t polynomial, uint32_t initial, const char* data);
  void asm_sha256(uint32_t* output_hash, const uint8_t* data_block);
}

#endif // !__IDSS_HASHTOOLS
