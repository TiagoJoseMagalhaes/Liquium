#include "memory.hpp"

#include <stdlib.h>
#include <string.h>

namespace liq
{
	
	void* alloc(uint64 size)
	{
		return malloc(size);
	}
	
	void* realloc(void* ptr, uint64 new_size)
	{
		// TODO(Tiago): we might want to have some checks for null here
		return ::realloc(ptr, new_size);
	}
	
	void free(void* ptr)
	{
		// TODO(Tiago): might wanna have some checks for null here
		::free(ptr);
	}
	
	// TODO(Tiago): placeholder
	void memcpy(void* source, void* dest, uint64 amount_to_copy, uint64 offset)
	{
		::memcpy(dest, (uint8*)source + offset, amount_to_copy);
	}
	
}