unittest {
    auto v = new ListNode!int(3);
    assert(v.value == 3, "values should be equal to 3");
    assert((new ListNode!int(3)).value == (new ListNode!(double)(3)).value, "Casting between int and double should be implicit");
}

struct ListNode(T) {
    T m_value;
    ListNode!(T)* m_next;

    this(T value) {
        m_value = value;
        m_next = null;
    }

    ~this() {
        m_next = null;
    }

    @property T value() { return m_value; }
    @property void value(T value) { m_value = value; }

    @property ListNode!(T)* next() { return m_next; }
    @property void next(ListNode!(T)* val) { m_next = val; }
}

