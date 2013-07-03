package com.alumni.controller;

public class SuperAction extends org.apache.struts.action.Action {

    protected MethodFactory f;

    public SuperAction() {
        super();
        f = new MethodFactory();
    }
}
