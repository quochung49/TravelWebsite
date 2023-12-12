package customTags;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

public class PagerTag extends TagSupport {

    private int pageIndex;
    private int totalPages;
    private int displayPages; // Number of specific pages to display;
    private int pageSize;

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public void setDisplayPages(int displayPages) {
        this.displayPages = displayPages;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    @Override
    public int doStartTag() throws JspException {
        try {
            pageContext.getOut().println("<div class='pager'>");

            // Calculate the range of specific pages to display
            int startPage = Math.max(1, pageIndex - displayPages / 2);
            int endPage = Math.min(totalPages, startPage + displayPages - 1);
            startPage = Math.max(1, endPage - displayPages + 1);

            // Display specific page links within the range
            for (int i = startPage; i <= endPage; i++) {
                if (i == pageIndex) {
                    pageContext.getOut().println("<a class='btn btn-outline-light current-page active'>" + i + "</a>");
                } else {
                    pageContext.getOut().println("<a class='btn btn-outline-light' href='javascript:void(0);' onclick='loadBookList(" + i + ", " + pageSize + ")'>" + i + "</a>");
                }
            }

            pageContext.getOut().println("</div>");
        } catch (IOException e) {
            throw new JspException(e);
        }
        return SKIP_BODY;
    }

//    @Override
//    public int doStartTag() throws JspException {
//        try {
//            pageContext.getOut().println("<div class='pager'>");
//
//            // Calculate the range of specific pages to display
//            int startPage = Math.max(1, pageIndex - displayPages / 2);
//            int endPage = Math.min(totalPages, startPage + displayPages - 1);
//            startPage = Math.max(1, endPage - displayPages + 1);
//
//            // Display specific page links within the range
//            for (int i = startPage; i <= endPage; i++) {
//                if (i == pageIndex) {
//                    pageContext.getOut().println("<a class='btn btn-outline-dark active' href='#'>" + i + "</a>");
//                } else {
//                    pageContext.getOut().println("<a class='btn btn-outline-dark' href='booklist?pageIndex=" + i + "&pageSize=" + pageSize + "'>" + i + "</a>");
//                }
//            }
//
//            pageContext.getOut().println("</div>");
//        } catch (IOException e) {
//            throw new JspException(e);
//        }
//        return SKIP_BODY;
//    }
}
