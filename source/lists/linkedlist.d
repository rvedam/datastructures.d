unittest {
    auto l1 = new LinkedList!int;
    auto l2 = new LinkedList!int;

    assert(l1.empty(), "l1 should be empty");
    assert(l2.empty(), "l1 should be empty");

    foreach(i; 0..6) {
        l1.append(i);
    }

    foreach(i; 6..10) {
        l2.append(i);
    }

    assert(l1.head.value == 0, "head of first list should be 0");
    assert(l2.head.value == 6, "head of second list should be 6");
    assert(l1.length == 6, "length of first list should be 5");
    assert(l2.length == 4, "length of second list should be 4");
    l1.concat(l2);
    assert(l1.length == 10, "length of l1 should now be l1.length + l2.length = 10");
    l1.remove(3);
    assert(l1.length == 9);
}

//
// Instead of creating LinkedList as a class we are creating it as a struct. The reason is
// classes and structs have different semantics in D. Structs are considered value-types where
// as classes are considered reference types. In D, pointers can not be used with reference-types
// only with value types. This is for the purposes of prevent object-slicing (https://en.wikipedia.org/wiki/Object_slicing)
//
struct LinkedList(T) {
  import listnode;
  ListNode!(T)* m_head;
  int count;

  ListNode!(T)* searchForLastListNode(ListNode!(T)* curListNode) {
    auto tmp = m_head;
    while(tmp.next !is null) 
    {
      tmp = tmp.next;
    }

    return tmp;
  }

  @property ListNode!(T)* head() { return this.m_head; }
  @property void head(ListNode!(T)* nhead) {
    this.m_head = nhead;
  }

  void append(T value) 
  {
    ListNode!(T)* newListNode = cast(ListNode!(T)*)(new ListNode!(T)(value));
    if(empty())
    {
      this.m_head = newListNode;
    }
    else
    {
      auto tmp = searchForLastListNode(this.m_head);
      tmp.next = newListNode;
    }
    ++this.count;
  }

  int length() const @property { return this.count; }

  void concat(LinkedList!(T)* l2) {
    auto tmp = searchForLastListNode(this.m_head);
    tmp.next = l2.head;
    this.count += l2.count;
  }

  void remove(T value)
  {
    if(head.value == value)
    {
      auto tmp = head;
      this.head = head.next;
      delete tmp;
    }
    else 
    {
      for(auto tmp = head; tmp.next !is null; tmp = tmp.next)
      {
        if(tmp.next.value == value)
        {
          auto delNode = tmp.next;
          tmp.next = tmp.next.next;
          delete delNode;
          --this.count;
          break;
        }
      }
    }
  }

  bool contains(T value)
  {
    return false;
  }

  bool empty()
  {
    return this.count == 0;
  }
}

