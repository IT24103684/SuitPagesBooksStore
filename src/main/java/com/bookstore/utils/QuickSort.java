package com.bookstore.utils;

import com.bookstore.models.Book;

public class QuickSort {

    public static void sortBooksByPrice(Book[] books, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(books, low, high);
            sortBooksByPrice(books, low, pivotIndex - 1);
            sortBooksByPrice(books, pivotIndex + 1, high);
        }
    }

    private static int partition(Book[] books, int low, int high) {
        double pivot = books[high].getPrice();
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (books[j].getPrice() <= pivot) {
                i++;
                swap(books, i, j);
            }
        }

        swap(books, i + 1, high);
        return i + 1;
    }

    private static void swap(Book[] books, int i, int j) {
        Book temp = books[i];
        books[i] = books[j];
        books[j] = temp;
    }

    public static <T> void sort(T[] array, Comparator<T> comparator, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(array, comparator, low, high);
            sort(array, comparator, low, pivotIndex - 1);
            sort(array, comparator, pivotIndex + 1, high);
        }
    }

    private static <T> int partition(T[] array, Comparator<T> comparator, int low, int high) {
        T pivot = array[high];
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (comparator.compare(array[j], pivot) <= 0) {
                i++;
                swap(array, i, j);
            }
        }

        swap(array, i + 1, high);
        return i + 1;
    }

    private static <T> void swap(T[] array, int i, int j) {
        T temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }

    public interface Comparator<T> {
        int compare(T o1, T o2);
    }
}