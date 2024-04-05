package org.fruttaeverdura.fruttaeverdura.model.dao.exception;

public class DataTruncationException extends Exception{
    /**
     * Creates a new instance of
     * <code>DuplicatedObjectException</code> without detail message.
     */
    public DataTruncationException() {
    }

    /**
     * Constructs an instance of
     * <code>DuplicatedObjectException</code> with the specified detail message.
     *
     * @param msg the detail message.
     */
    public DataTruncationException(String msg) {
        super(msg);
    }
}
