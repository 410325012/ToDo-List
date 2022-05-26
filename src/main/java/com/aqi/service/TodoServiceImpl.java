package com.aqi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aqi.model.Todo;
import com.aqi.model.TodoRepository;

@Service
@Transactional
public class TodoServiceImpl implements TodoService{
	
	@Autowired
	private TodoRepository tRepo;

	@Override
	public List<Todo> findAll() {
		return tRepo.findAll();
	}

	@Override
	public Todo saveTodo(Todo t) {
		return tRepo.save(t);
	}

	@Override
	public void deleteById(int id) {
		tRepo.deleteById(id);
	}

	@Override
	public Todo findById(int id) {
		return tRepo.findById(id).get();
	}

}
