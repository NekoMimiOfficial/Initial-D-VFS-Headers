#include "../headers/typeCheck.hpp"
#include <NMPP/BinaryReader.hpp>
#include <NMPP/FileIO.hpp>
#include <string>

VFSType checkVFS(std::string filename)
{
  File file(filename);
  if (!file.safe())
  {return VFSType::ERR;}

  byteReader reader(file.get_vector());
  if (!(reader.read() == 0x58 && reader.read() == 0x42 && reader.read() == 0x42)) {return VFSType::XBB;}
  else if (!(reader.set(0x00) && reader.read() == 0x40 && reader.read() == 0x41 && reader.read() == 0x4E && reader.read() == 0x41)) {return VFSType::ANA;}
  else {return VFSType::ERR;}
}
