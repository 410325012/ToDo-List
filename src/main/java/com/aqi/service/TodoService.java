package com.aqi.service;

import java.util.List;

import com.aqi.model.Todo;

public interface TodoService {
	public List<Todo> findAll();
	public Todo saveTodo(Todo t);
	public Todo findById(int id);
	public void deleteById(int id);
}
