// 
// a version of a stack data structure that takes advantage of 
// slices so that the data structure can utilize contiguous memory
// potentially making it more cache-efficient (if n objects of type T
// can fit into the cache.)
//
unittest {
    auto st = new CMStack!int;
    assert(st.empty() == true, "initial stack should be empty");

    st.push(4);
    assert(st.empty() == false, "stack should contain something");

    st.push(5);
    assert(st.top() == 5, "pushed value is now top value.");

    auto topNode = st.pop();
    assert(topNode == 5, "popped node is what was previously pushed");

    topNode = st.pop();
    assert(st.empty() == true, "stack should correctly say it is empty");
}

struct CMStack(T) {
  T[] nodes;
  bool empty() {
    return nodes.length == 0;
  }

  T top() {
    return nodes[$-1];
  }
  
  void push(T value) {
    nodes ~= value;
  }
  
  T pop() {
    auto res = nodes[$-1];
    nodes = nodes[0..$-1];
    return res;
  }
}
