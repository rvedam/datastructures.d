import std.stdio;
import std.exception;
import listnode;

void main()
{
    auto v = new ListNode!int(3);
	writeln("v.value = " , v.value);
    v.value = 4;
	writeln("v.value = " , v.value);
}

