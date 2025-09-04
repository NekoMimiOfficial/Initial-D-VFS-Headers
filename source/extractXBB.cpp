#include "../headers/extractXBB.hpp"
#include <NMPP/BinaryReader.hpp>
#include <NMPP/Converters.hpp>
#include <NMPP/outTools.hpp>
#include <NMPP/FileIO.hpp>
#include <vector>
#include <string>
#include <cstddef>
#include <cstdint>

XBBExtractor::XBBExtractor(std::string fn)
{filename= fn;}

struct XBB XBBExtractor::extract()
{
  File file(filename);
  if (!file.safe())
  {XBB invalid; invalid.file_count= 65;invalid.valid= false; writer::error("XBBExtractor::extract", "The file provided is unsafe.");return invalid;}

  byteReader reader(file.get_vector());

  // Read the file type (3 bytes)
  if (!(reader.read() == 0x58 && reader.read() == 0x42 && reader.read() == 0x42))
  {XBB invalid; invalid.file_count= 66;invalid.valid= false; writer::error("XBBExtractor::extract", "Not an XBB file.");return invalid;}

  // Read the Flag 4 and initialize XBB struct
  XBB xbb;
  xbb.flag_4= reader.read();

  // Read file count
  xbb.file_count= reader.read();

  // Seek to 0x20 (end of header)
  reader.set(0x20);

  // List of XBB items
  for (size_t i= 0; i < xbb.file_count; i++)
  {
    //set index
    size_t index_current= i;

    // Initialize item
    XBBitem item;
    item.index= index_current;

    // Read start pointer
    uint8_t* buffer_ptr_start= reader.read(4);
    item.ptr_start= buffer_ptr_start[0] | (buffer_ptr_start[1] << 8) | (buffer_ptr_start[2] << 16) | (buffer_ptr_start[3] << 24);

    // Read size pointer (not really a pointer lol)
    uint8_t* buffer_ptr_size= reader.read(4);
    item.ptr_size= buffer_ptr_size[0] | (buffer_ptr_size[1] << 8) | (buffer_ptr_size[2] << 16) | (buffer_ptr_size[3] << 24);

    // Read filename pointer
    uint8_t* buffer_ptr_fn= reader.read(4);
    item.ptr_name= buffer_ptr_fn[0] | (buffer_ptr_fn[1] << 8) | (buffer_ptr_fn[2] << 16) | (buffer_ptr_fn[3] << 24);

    // Read CRC
    uint8_t* buffer_hash= reader.read(4);
    item.crc= buffer_hash[0] | (buffer_hash[1] << 8) | (buffer_hash[2] << 16) | (buffer_hash[3] << 24);

    // Store the item for now
    xbb.items.push_back(item);
  }

  // Getting the filenames
  for (size_t i= 0; i < xbb.file_count; i++)
  {
    // Set the current index
    size_t index_current= i;

    // Set the reader to the filename pointer of the item
    reader.set(xbb.items[index_current].ptr_name);

    // Begin extraction
    std::vector<uint8_t> bufferFileName;
    while (1)
    {
      uint8_t readByte= reader.read();
      if (readByte == 0x0) {break;}
      bufferFileName.push_back(readByte);
    }

    // Here we turn the buffer into a word
    uint8_t* word= new uint8_t[bufferFileName.size()];
    for (size_t j= 0; j < bufferFileName.size(); j++)
    {
      word[j]= bufferFileName[j];
    }

    // Finally set the name in the item
    xbb.items[index_current].filename= convert::uchar2string(word);
  }

  // Getting the data
  for (size_t i= 0; i < xbb.file_count; i++)
  {
    // Set the current index
    size_t index_current= i;

    // Calculate when to stop reading
    uint32_t toRead= xbb.items[index_current].ptr_size;

    // Start reading data
    reader.set(xbb.items[index_current].ptr_start);
    while (1)
    {
      if (toRead <= 0) {break;}
      toRead--; xbb.items[index_current].data.push_back(reader.read());
    }
  }

  return xbb;
}
