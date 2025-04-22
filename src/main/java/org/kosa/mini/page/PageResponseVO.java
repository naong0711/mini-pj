package org.kosa.mini.page;

import java.util.List;

import lombok.Data;

@Data
public class PageResponseVO <T> {

	private List<T> list; // ���
	private int totalCount = 0;
	private int totalPage = 0; // ��ü ������ ��
	private int startPage = 0; // ������ �׺���̼� ���� ���� ��������ȣ
	private int endPage = 0; // ������ �׺���̼� ���� �� ��������ȣ
	private int pageNo = 0; // ���� ��������ȣ
	private int size = 10; // �� �������� ��µǴ� �ڷ��� �Ǽ�
	private String searchValue = ""; // �� �������� ��µǴ� �ڷ��� �Ǽ�

	public PageResponseVO(String searchValue, int pageNo, List<T> list, int totalCount, int size) {

		this.totalCount = totalCount;
		this.pageNo = pageNo;
		this.list = list;
		this.size = size;
		this.searchValue = searchValue;

		// 2. (���� �Ǽ� / 10)�� ���� �ø� -> ��ü��������
		totalPage = (int) Math.ceil((double) totalCount / size);

		// 301 -> endPage : 31
		// pageNoNumber : 30 , start: 21, end:30
		// pageNoNumber : 31 , start: 31, end:40, ���� : 31
		startPage = ((pageNo - 1) / 10) * 10 + 1;
		endPage = ((pageNo - 1) / 10) * 10 + 10;
		if (endPage > totalPage)
			endPage = totalPage;

	}

	public boolean isPrev() {
		return startPage != 1;
	}

	public boolean isNext() {
		return totalPage != endPage;
	}

	

}
