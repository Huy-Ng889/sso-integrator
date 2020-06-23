package com.bsc.sso.authentication.util;

import com.auth0.jwt.algorithms.Algorithm;
import com.bsc.sso.authentication.SSOAuthenticationConstants;
import com.bsc.sso.authentication.token.TokenUtil;
import com.bsc.sso.authentication.token.object.Token;
import com.bsc.sso.authentication.token.object.TokenHeader;
import com.bsc.sso.authentication.token.object.TokenPayload;
import org.apache.oltu.oauth2.as.request.OAuthAuthzRequest;
import org.apache.oltu.oauth2.common.OAuth;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.NewCookie;
import java.util.Calendar;

public class CommonUtil {

    public enum HeaderType {
        BASIC, BEARER
    }

    /**
     * get full URL SSO to redirect
     *
     * @param request
     * @return
     */
    public static String getFullURLSSORedirect(HttpServletRequest request) {
        String callbackUrl = CommonUtil.getContextPath(request) + SSOAuthenticationConstants.CALLBACK_URL;
        return callbackUrl;
    }

    public static String getContextPath(HttpServletRequest request) {
        StringBuffer url = request.getRequestURL();
        String uri = request.getRequestURI();
        String ctx = request.getContextPath();
        String contextPath = url.substring(0, url.length() - uri.length() + ctx.length());
        return contextPath;
    }

    public static String generateCookie(String username, int timeExpire) {
        try {
            TokenPayload tokenPayload = new TokenPayload();
            TokenHeader tokenHeader = new TokenHeader();

            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.SECOND, timeExpire);

            tokenPayload.setUsername(username);
            tokenPayload.setExp(calendar.getTimeInMillis());

            String pemKey = FileUtil.getStringFromResource("private.pem");
            Algorithm alg = TokenUtil.getAlgWithRSA256(pemKey);

            Token token = new Token(alg, tokenHeader, tokenPayload);
            return token.getToken();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static NewCookie[] getCookieAsParams(HttpServletRequest request) {
        NewCookie[] result = new NewCookie[3];
        String clientId = request.getParameter(OAuth.OAUTH_CLIENT_ID);
        String responseType = request.getParameter(OAuth.OAUTH_RESPONSE_TYPE);
        String redirectUri = request.getParameter(OAuth.OAUTH_REDIRECT_URI);
//        String domainName = request.getServerName();
//        String domainNamePrefix = domainName.substring(domainName.indexOf("."), domainName.length());
        result[0] = new NewCookie(SSOAuthenticationConstants.CLIENT_ID_COOKIE, clientId, "/", null, null, Integer.MAX_VALUE, false);
        result[1] = new NewCookie(SSOAuthenticationConstants.RESPONSE_TYPE_COOKIE, responseType, "/", null, null, Integer.MAX_VALUE, false);
        result[2] = new NewCookie(SSOAuthenticationConstants.REDIRECT_URI_COOKIE, redirectUri, "/", null, null, Integer.MAX_VALUE, false);
        return result;
    }

    public static NewCookie[] deleteAllCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        NewCookie[] newCookies = new NewCookie[cookies.length];
        for (int i = 0; i < cookies.length; i++) {
            String name = cookies[i].getName();
            NewCookie cookie = new NewCookie(name, "", "/", null, null, 0, false);
            newCookies[i] = cookie;
        }

        return newCookies;
    }

    public static void setParamsAsCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();

        for (int i = 0; i < cookies.length; i++) {
            String name = cookies[i].getName();
            String value = cookies[i].getValue();
            if (name.equals(SSOAuthenticationConstants.CLIENT_ID_COOKIE)
                    || name.equals(SSOAuthenticationConstants.RESPONSE_TYPE_COOKIE)
                    || name.equals(SSOAuthenticationConstants.REDIRECT_URI_COOKIE)) {
                request.setAttribute(name, value);
            }
        }

    }

    public static String getHeaderAuthorizationValue(HttpServletRequest request, HeaderType type) {
        String authTokenHeader = request.getHeader("Authorization");
        String headerPrefix = null;
        if (type.equals(HeaderType.BASIC)) {
            headerPrefix = "Basic ";
        } else if (type.equals(HeaderType.BEARER)) {
            headerPrefix = "Bearer ";
        }
        if (authTokenHeader != null && headerPrefix != null && authTokenHeader.startsWith(headerPrefix)) {
            return authTokenHeader.substring(headerPrefix.length());
        }
        return null;
    }
}
