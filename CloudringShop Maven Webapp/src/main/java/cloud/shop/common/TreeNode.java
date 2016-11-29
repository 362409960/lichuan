package cloud.shop.common;

import java.util.List;
/**
 * 简单树的展示类
 * @author lichuan
 *
 */
public class TreeNode {

	private String id;

	private String text;

	private List<TreeNode> children;

	public TreeNode(String id, String text) {
		this.id = id;
		this.text = text;
	}

	public TreeNode() {

	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public List<TreeNode> getChildren() {
		return children;
	}

	public void setChildren(List<TreeNode> children) {
		this.children = children;
	}

}
