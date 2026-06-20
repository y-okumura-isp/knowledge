package org.support.project.knowledge.logic;

import org.apache.http.HttpHost;
import org.apache.http.conn.params.ConnRoutePNames;
import org.apache.http.impl.client.DefaultHttpClient;
import org.junit.Assert;
import org.junit.Test;
import org.support.project.knowledge.TestCommon;
import org.support.project.web.entity.ProxyConfigsEntity;

public class HttpLogicTest extends TestCommon {

    private static class TestHttpLogic extends HttpLogic {
        public DefaultHttpClient create(ProxyConfigsEntity proxyConfig) throws Exception {
            return (DefaultHttpClient) createHttpClient(proxyConfig);
        }
    }

    @Test
    public void testCreateHttpClientWithoutProxy() throws Exception {
        TestHttpLogic logic = new TestHttpLogic();

        DefaultHttpClient client = logic.create(null);

        Assert.assertNotNull(client);
        Assert.assertNull(client.getParams().getParameter(ConnRoutePNames.DEFAULT_PROXY));
    }

    @Test
    public void testCreateHttpClientWithProxy() throws Exception {
        TestHttpLogic logic = new TestHttpLogic();
        ProxyConfigsEntity proxyConfig = new ProxyConfigsEntity();
        proxyConfig.setProxyHostName("proxy.example.com");
        proxyConfig.setProxyPortNo(8080);

        DefaultHttpClient client = logic.create(proxyConfig);

        Assert.assertNotNull(client);
        HttpHost proxy = (HttpHost) client.getParams().getParameter(ConnRoutePNames.DEFAULT_PROXY);
        Assert.assertNotNull(proxy);
        Assert.assertEquals("proxy.example.com", proxy.getHostName());
        Assert.assertEquals(8080, proxy.getPort());
    }
}
