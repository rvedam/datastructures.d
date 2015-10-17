//
// classic stack (LIFO) implementation
// using reference types
//
unittest {
    auto st = new Stack!int;
    assert(st.empty() == true, "initial stack should be empty");

    st.push(4);
    assert(st.empty() == false, "stack should contain something");

    st.push(5);
    assert(st.top().value == 5, "pushed value is now top value.");

    auto topNode = st.pop();
    assert(topNode.value == 5, "popped node is what was previously pushed");

    topNode = st.pop();
    assert(st.empty() == true, "stack should correctly say it is empty");
}

struct Stack(T) {
    import listnode;
    ListNode!(T)* m_top;

    bool empty() {
        return m_top == null;
    }

    ListNode!(T)* top() { return this.m_top; }

    void push(T value) {
        auto newNode = new ListNode!(T)(value);
        newNode.next = m_top;
        m_top = newNode;
    }

    ListNode!(T)* pop() {
        auto res = m_top;
        m_top = m_top.next;
        res.next = null;
        return res;
    }
}
