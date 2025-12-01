package com.bookstore.utils;

import java.util.Iterator;
import java.util.NoSuchElementException;

public class LinkedList<T> implements Iterable<T> {
    private Link<T> First;
    private Link<T> Last;
    private int size;

    private static class Link<T> {
        T data;
        Link<T> next;

        Link(T data) {
            this.data = data;
            this.next = null;
        }
    }

    public LinkedList() {
        First = null;
        Last = null;
        size = 0;
    }

    public void add(T data) {
        Link<T> newNode = new Link<>(data);

        if (First == null) {
            First = newNode;
            Last = newNode;
        } else {
            Last.next = newNode;
            Last = newNode;
        }

        size++;
    }

    public void addFirst(T data) {
        Link<T> newNode = new Link<>(data);

        if (First == null) {
            First = newNode;
            Last = newNode;
        } else {
            newNode.next = First;
            First = newNode;
        }

        size++;
    }


    public T removeFirst() {
        if (First == null) {
            System.out.println("List is empty");
        }

        T data = First.data;
        First = First.next;

        if (First == null) {
            Last = null;
        }

        size--;
        return data;
    }

    public T removeLast() {
        if (First == null) {
            System.out.println("List is empty");
        }

        if (First == Last) {
            T data = First.data;
            First = null;
            Last = null;
            size--;
            return data;
        }

        Link<T> current = First;
        while (current.next != Last) {
            current = current.next;
        }

        T data = Last.data;
        Last = current;
        Last.next = null;

        size--;
        return data;
    }

    public T remove(int index) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Index: " + index + ", Size: " + size);
        }

        if (index == 0) {
            return removeFirst();
        }

        if (index == size - 1) {
            return removeLast();
        }

        Link<T> prev = First;
        for (int i = 0; i < index - 1; i++) {
            prev = prev.next;
        }

        T data = prev.next.data;
        prev.next = prev.next.next;

        size--;
        return data;
    }

    public boolean remove(T item) {
        if (First == null) {
            return false;
        }

        if (First.data.equals(item)) {
            removeFirst();
            return true;
        }

        Link<T> current = First;
        while (current.next != null && !current.next.data.equals(item)) {
            current = current.next;
        }

        if (current.next == null) {
            return false;
        }

        if (current.next == Last) {
            Last = current;
        }

        current.next = current.next.next;
        size--;

        return true;
    }

    public int size() {
        return size;
    }

    public boolean isEmpty() {
        return size == 0;
    }

    @Override
    public Iterator<T> iterator() {
        return new Iterator<T>() {
            private Link<T> current = First;

            @Override
            public boolean hasNext() {
                return current != null;
            }

            @Override
            public T next() {
                if (!hasNext()) {
                    throw new NoSuchElementException();
                }
                T data = current.data;
                current = current.next;
                return data;
            }
        };
    }


}