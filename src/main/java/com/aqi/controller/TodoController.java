package com.aqi.controller;

import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aqi.model.Todo;
import com.aqi.service.TodoService;

@Controller
@RequestMapping
public class TodoController {
	
	@Autowired
	private TodoService tService;
	
	@GetMapping("todo")
	public String ShowToDoListIndex(Model m) {
		m.addAttribute("todolist", tService.findAll());
		return "todoindex";
	}
	
	@PostMapping("todo")
	@ResponseBody
	public Todo AddToDoList(Todo t) {
		return tService.saveTodo(t);
	}
	
	@DeleteMapping("todo/{id}")
	@ResponseBody
	public void DeleteToDoList(@PathVariable("id")int id) {
		tService.deleteById(id);
	}
	
	@PutMapping("todo/{id}")
	@ResponseBody
	public Todo UpdateToDoList(@PathVariable("id")int id) {
		Todo result = tService.findById(id);
		result.setStatus("已完成");
		result.setUpdatetime(new Timestamp(System.currentTimeMillis()));
		return tService.saveTodo(result);
	}

}
