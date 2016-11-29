package cloud.app.commodity.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.app.commodity.service.OutlineService;

@Controller
@RequestMapping("/admin/outline")
public class OutlineController {
	@Autowired
	private OutlineService outlineService;

}
