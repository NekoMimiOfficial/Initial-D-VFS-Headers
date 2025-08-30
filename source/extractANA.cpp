#include "../headers/extractANA.hpp"
#include <NMPP/BinaryReader.hpp>
#include <NMPP/Converters.hpp>
#include <NMPP/FileIO.hpp>
#include <cstddef>
#include <cstdint>
#include <vector>

Extractor::Extractor(std::string fn)
{filename= fn;}

ANA Extractor::extract()
{
  File file(filename);
  if (!file.safe())
  {ANA invalid; invalid.valid= false; return invalid;}

  byteReader reader(file.get_vector());

  // Read the file type (4 bytes)
  if (!(reader.read() == 0x40 && reader.read() == 0x41 && reader.read() == 0x4E && reader.read() == 0x41))
  {ANA invalid; invalid.valid= false; return invalid;}

  // Initialize ANA object
  ANA ana;

  // Skip to file count pointer
  reader.set(0x10);
  ana.file_count= reader.read();

  // Skip header
  reader.set(0x20);

  // Start Extraction
  for (size_t i= 0; i < ana.file_count; i++)
  {
    size_t index_current= i;

    // Create a new ANA item
    ANAitem item;
    item.index= index_current;

    // Set start and size pointers
    item.ptr_start= reader.read() | (reader.read() << 8) | (reader.read() << 16) | (reader.read() << 24);
    item.ptr_size= reader.read() | (reader.read() << 8) | (reader.read() << 16) | (reader.read() << 24);

    // Read partial filename
    std::vector<uint8_t> bufferFileName;
    while (1)
    {
      // Continue reading until you hit a nullptr
      uint8_t byteRead= reader.read();
      if (byteRead == 0x0) {break;}
      bufferFileName.push_back(byteRead);

      // creating the word
      uint8_t* word= new uint8_t[bufferFileName.size()];
      for (size_t j= 0; j < bufferFileName.size(); j++)
      {word[j]= bufferFileName[j];}

      // Setting the filename
      item.filename= convert::uchar2string(word);

      // add to main ANA
      ana.items.push_back(item);
    }
  }

  // Getting the data
  for (size_t i= 0; i < ana.file_count; i++)
  {
    // Set the current index
    size_t index_current= i;

    // Calculate when to stop reading
    uint32_t toRead= ana.items[index_current].ptr_size;

    // Start reading data
    reader.set(ana.items[index_current].ptr_size);
    while (1)
    {
      if (toRead <= 0) {break;}
      toRead--; ana.items[index_current].data.push_back(reader.read());
    }
  }

  return ana;

}
