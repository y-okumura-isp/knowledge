package org.support.project.web.filter;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemHeaders;
import org.junit.Assert;
import org.junit.Test;
import org.support.project.web.test.stub.StubHttpServletRequest;
import org.support.project.web.test.stub.StubHttpServletResponse;

public class MultipartFilterTest {

    private static class TestMultipartFilter extends MultipartFilter {
        public void initForTest() throws ServletException {
            super.init((FilterConfig) null);
        }
    }

    private static class StubFileItem implements FileItem {
        private final String fieldName;
        private final String value;
        private final boolean formField;

        StubFileItem(String fieldName, String value, boolean formField) {
            this.fieldName = fieldName;
            this.value = value;
            this.formField = formField;
        }

        @Override
        public InputStream getInputStream() throws IOException {
            return new ByteArrayInputStream(value.getBytes());
        }

        @Override
        public String getContentType() {
            return "text/plain";
        }

        @Override
        public String getName() {
            return fieldName;
        }

        @Override
        public boolean isInMemory() {
            return true;
        }

        @Override
        public long getSize() {
            return value.length();
        }

        @Override
        public byte[] get() {
            return value.getBytes();
        }

        @Override
        public String getString(String encoding) {
            return value;
        }

        @Override
        public String getString() {
            return value;
        }

        @Override
        public void write(java.io.File file) throws Exception {
        }

        @Override
        public void delete() {
        }

        @Override
        public String getFieldName() {
            return fieldName;
        }

        @Override
        public void setFieldName(String name) {
        }

        @Override
        public boolean isFormField() {
            return formField;
        }

        @Override
        public void setFormField(boolean state) {
        }

        @Override
        public OutputStream getOutputStream() throws IOException {
            return new java.io.ByteArrayOutputStream();
        }

        @Override
        public FileItemHeaders getHeaders() {
            return null;
        }

        @Override
        public void setHeaders(FileItemHeaders headers) {
        }
    }

    @Test
    public void testDoFilterNonMultipartPassThrough() throws Exception {
        TestMultipartFilter filter = new TestMultipartFilter();
        filter.initForTest();

        StubHttpServletRequest request = new StubHttpServletRequest();
        request.setMethod("post");
        request.setAttribute("contentType", "application/x-www-form-urlencoded");
        StubHttpServletResponse response = new StubHttpServletResponse(request);
        final boolean[] called = { false };

        filter.doFilter(request, response, new FilterChain() {
            @Override
            public void doFilter(javax.servlet.ServletRequest req, javax.servlet.ServletResponse res) {
                called[0] = true;
            }
        });

        Assert.assertTrue(called[0]);
    }

    @Test
    public void testRequestStubHandlesAttributeLists() {
        StubHttpServletRequest request = new StubHttpServletRequest();
        request.setAttribute("field", "first");
        Assert.assertEquals("first", request.getAttribute("field"));
    }

    @Test
    public void testStubHttpServletResponseStatus() {
        StubHttpServletRequest request = new StubHttpServletRequest();
        StubHttpServletResponse response = new StubHttpServletResponse(request);
        response.setStatus(200);
        Assert.assertEquals(200, response.getStatus());
    }
}
