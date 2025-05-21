package com.bookstore.utils;

import java.util.Iterator;
import java.util.NoSuchElementException;

public class LinkedList<T> implements Iterable<T> {
    private Node<T> head;
    private Node<T> tail;
    private int size;

    private static class Node<T> {
        T data;
        Node<T> next;

        Node(T data) {
            this.data = data;
            this.next = null;
        }
    }

    public LinkedList() {
        head = null;
        tail = null;
        size = 0;
    }

    public void add(T data) {
        Node<T> newNode = new Node<>(data);

        if (head == null) {
            head = newNode;
            tail = newNode;
        } else {
            tail.next = newNode;
            tail = newNode;
        }

        size++;
    }

    public void addFirst(T data) {
        Node<T> newNode = new Node<>(data);

        if (head == null) {
            head = newNode;
            tail = newNode;
        } else {
            newNode.next = head;
            head = newNode;
        }

        size++;
    }

    public T get(int index) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Index: " + index + ", Size: " + size);
        }

        Node<T> current = head;
        for (int i = 0; i < index; i++) {
            current = current.next;
        }

        return current.data;
    }

    public T removeFirst() {
        if (head == null) {
            throw new NoSuchElementException();
        }

        T data = head.data;
        head = head.next;

        if (head == null) {
            tail = null;
        }

        size--;
        return data;
    }

    public T removeLast() {
        if (head == null) {
            throw new NoSuchElementException();
        }

        if (head == tail) {
            T data = head.data;
            head = null;
            tail = null;
            size--;
            return data;
        }

        Node<T> current = head;
        while (current.next != tail) {
            current = current.next;
        }

        T data = tail.data;
        tail = current;
        tail.next = null;

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

        Node<T> prev = head;
        for (int i = 0; i < index - 1; i++) {
            prev = prev.next;
        }

        T data = prev.next.data;
        prev.next = prev.next.next;

        size--;
        return data;
    }

    public boolean remove(T item) {
        if (head == null) {
            return false;
        }

        if (head.data.equals(item)) {
            removeFirst();
            return true;
        }

        Node<T> current = head;
        while (current.next != null && !current.next.data.equals(item)) {
            current = current.next;
        }

        if (current.next == null) {
            return false;
        }

        if (current.next == tail) {
            tail = current;
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

    public void clear() {
        head = null;
        tail = null;
        size = 0;
    }

    @Override
    public Iterator<T> iterator() {
        return new Iterator<T>() {
            private Node<T> current = head;

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

    public Object[] toArray() {
        Object[] array = new Object[size];
        Node<T> current = head;
        int index = 0;

        while (current != null) {
            array[index++] = current.data;
            current = current.next;
        }

        return array;
    }

    public static <T> LinkedList<T> fromArray(T[] array) {
        LinkedList<T> list = new LinkedList<>();
        for (T item : array) {
            list.add(item);
        }
        return list;
    }
}