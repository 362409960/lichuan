package cloud.app.common.async;



//回调接口
public interface CallBack {
	//执行回调方法 ,将处理后的结果作为参数返回给回调方法
	public void execute(String backStr) throws Exception;
}
