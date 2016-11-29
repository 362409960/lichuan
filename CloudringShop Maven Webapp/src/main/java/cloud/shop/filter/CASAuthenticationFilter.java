package cloud.shop.filter;



import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jasig.cas.client.authentication.AuthenticationRedirectStrategy;
import org.jasig.cas.client.authentication.ContainsPatternUrlPatternMatcherStrategy;
import org.jasig.cas.client.authentication.DefaultAuthenticationRedirectStrategy;
import org.jasig.cas.client.authentication.DefaultGatewayResolverImpl;
import org.jasig.cas.client.authentication.ExactUrlPatternMatcherStrategy;
import org.jasig.cas.client.authentication.GatewayResolver;
import org.jasig.cas.client.authentication.RegexUrlPatternMatcherStrategy;
import org.jasig.cas.client.authentication.UrlPatternMatcherStrategy;
import org.jasig.cas.client.util.AbstractCasFilter;
import org.jasig.cas.client.util.CommonUtils;
import org.jasig.cas.client.util.ReflectUtils;
import org.jasig.cas.client.validation.Assertion;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;

import cloud.shop.common.ImageUtil;


public class CASAuthenticationFilter extends AbstractCasFilter {
    /**
     * The URL to the CAS Server login.
     */
    private String casServerLoginUrl;

    /**
     * Whether to send the renew request or not.
     */
    private boolean renew = false;

    /**
     * Whether to send the gateway request or not.
     */
    private boolean gateway = false;
     private Integer count=0;
    private GatewayResolver gatewayStorage = new DefaultGatewayResolverImpl();

    private AuthenticationRedirectStrategy authenticationRedirectStrategy = new DefaultAuthenticationRedirectStrategy();
    
    private UrlPatternMatcherStrategy ignoreUrlPatternMatcherStrategyClass = null;
    
    private static final Map<String, Class<? extends UrlPatternMatcherStrategy>> PATTERN_MATCHER_TYPES =
            new HashMap<String, Class<? extends UrlPatternMatcherStrategy>>();
    
    static {
        PATTERN_MATCHER_TYPES.put("CONTAINS", ContainsPatternUrlPatternMatcherStrategy.class);
        PATTERN_MATCHER_TYPES.put("REGEX", RegexUrlPatternMatcherStrategy.class);
        PATTERN_MATCHER_TYPES.put("EXACT", ExactUrlPatternMatcherStrategy.class);
    }
    
    protected void initInternal(final FilterConfig filterConfig) throws ServletException {
        if (!isIgnoreInitConfiguration()) {
            super.initInternal(filterConfig);
            setCasServerLoginUrl(getPropertyFromInitParams(filterConfig, "casServerLoginUrl", null));
            logger.trace("Loaded CasServerLoginUrl parameter: {}", this.casServerLoginUrl);
            setRenew(parseBoolean(getPropertyFromInitParams(filterConfig, "renew", "false")));
            logger.trace("Loaded renew parameter: {}", this.renew);
            setGateway(parseBoolean(getPropertyFromInitParams(filterConfig, "gateway", "false")));
            logger.trace("Loaded gateway parameter: {}", this.gateway);
                       
            final String ignorePattern = getPropertyFromInitParams(filterConfig, "ignorePattern", null);
            logger.trace("Loaded ignorePattern parameter: {}", ignorePattern);
            
            final String ignoreUrlPatternType = getPropertyFromInitParams(filterConfig, "ignoreUrlPatternType", "REGEX");
            logger.trace("Loaded ignoreUrlPatternType parameter: {}", ignoreUrlPatternType);
            
            if (ignorePattern != null) {
                final Class<? extends UrlPatternMatcherStrategy> ignoreUrlMatcherClass = PATTERN_MATCHER_TYPES.get(ignoreUrlPatternType);
                if (ignoreUrlMatcherClass != null) {
                    this.ignoreUrlPatternMatcherStrategyClass = ReflectUtils.newInstance(ignoreUrlMatcherClass.getName());
                } else {
                    try {
                        logger.trace("Assuming {} is a qualified class name...", ignoreUrlPatternType);
                        this.ignoreUrlPatternMatcherStrategyClass = ReflectUtils.newInstance(ignoreUrlPatternType);
                    } catch (final IllegalArgumentException e) {
                        logger.error("Could not instantiate class [{}]", ignoreUrlPatternType, e);
                    }
                }
                if (this.ignoreUrlPatternMatcherStrategyClass != null) {
                    this.ignoreUrlPatternMatcherStrategyClass.setPattern(ignorePattern);
                }
            }
            
            final String gatewayStorageClass = getPropertyFromInitParams(filterConfig, "gatewayStorageClass", null);

            if (gatewayStorageClass != null) {
                this.gatewayStorage = ReflectUtils.newInstance(gatewayStorageClass);
            }
            
            final String authenticationRedirectStrategyClass = getPropertyFromInitParams(filterConfig,
                    "authenticationRedirectStrategyClass", null);

            if (authenticationRedirectStrategyClass != null) {
                this.authenticationRedirectStrategy = ReflectUtils.newInstance(authenticationRedirectStrategyClass);
            }
        }
    }

    public void init() {
        super.init();
        CommonUtils.assertNotNull(this.casServerLoginUrl, "casServerLoginUrl cannot be null.");
    }

    public final void doFilter(final ServletRequest servletRequest, final ServletResponse servletResponse,
            final FilterChain filterChain) throws IOException, ServletException {
        
        final HttpServletRequest request = (HttpServletRequest) servletRequest;
        final HttpServletResponse response = (HttpServletResponse) servletResponse;
        
        if (isRequestUrlExcluded(request)) {
            logger.debug("Request is ignored.");
            filterChain.doFilter(request, response);
            return;
        }
        
        final HttpSession session = request.getSession(false);
        final Assertion assertion = session != null ? (Assertion) session.getAttribute(CONST_CAS_ASSERTION) : null;

        if (assertion != null) {
            filterChain.doFilter(request, response);
            return;
        }
        //修改代码【不进行登录验证】
	    String requestStr = request.getRequestURL().toString();	  
	    System.out.println(requestStr);
	   
	    //去掉jsp后缀.jsp
	    if(requestStr.indexOf(".jsp")>0)
	    {
	    	requestStr=requestStr.substring(0, requestStr.indexOf(".jsp"));
	    }
	    PathMatcher matcher = new AntPathMatcher(); 
	    String excludePath=ImageUtil.getPropertiesFile().getProperty("register");
	    String [] arrexcludePath=excludePath.split(",");
	    for(int i=0;i<arrexcludePath.length;i++)
	    {
	    	boolean flag = matcher.match(arrexcludePath[i], requestStr); 
	        if(!flag){  
	            flag = requestStr.indexOf(arrexcludePath[i]) > 0;  
	        }  
	        if(flag){  
	            this.logger.debug("excludePath " + arrexcludePath[i] + " pass sso authentication");  
	            filterChain.doFilter(request, response);  
	            return;  
	        }  
	    }
	    
        
        final String serviceUrl = constructServiceUrl(request, response);
        final String ticket = retrieveTicketFromRequest(request);
        final boolean wasGatewayed = this.gateway && this.gatewayStorage.hasGatewayedAlready(request, serviceUrl);

        if (CommonUtils.isNotBlank(ticket) || wasGatewayed) {
            filterChain.doFilter(request, response);
            return;
        }
        String url=ImageUtil.getPropertiesFile().getProperty("interception.home");
        if(requestStr.equals(url))
        {
        	if(count==1)
        	{
        		 filterChain.doFilter(request, response);  
 	            return; 
        	}
        	else
        	{
        		count++;
        		  final String modifiedServiceUrl;

        	        logger.debug("no ticket and no assertion found");
        	        if (this.gateway) {
        	            logger.debug("setting gateway attribute in session");
        	            modifiedServiceUrl = this.gatewayStorage.storeGatewayInformation(request, serviceUrl);
        	        } else {
        	            modifiedServiceUrl = serviceUrl;
        	        }

        	        logger.debug("Constructed service url: {}", modifiedServiceUrl);

        	        final String urlToRedirectTo = CommonUtils.constructRedirectUrl(this.casServerLoginUrl,
        	                getServiceParameterName(), modifiedServiceUrl, this.renew, this.gateway);

        	        logger.debug("redirecting to \"{}\"", urlToRedirectTo);
        	        this.authenticationRedirectStrategy.redirect(request, response, urlToRedirectTo);
        	        return;
        	}
        }
        else
        {
        	if(count==1)
        	{
        		 filterChain.doFilter(request, response); 
        		 count=0;
 	            return; 
        	}
        	else
        	{
        		count=0;
            	final String modifiedServiceUrl;

                logger.debug("no ticket and no assertion found");
                if (this.gateway) {
                    logger.debug("setting gateway attribute in session");
                    modifiedServiceUrl = this.gatewayStorage.storeGatewayInformation(request, serviceUrl);
                } else {
                    modifiedServiceUrl = serviceUrl;
                }

                logger.debug("Constructed service url: {}", modifiedServiceUrl);

                final String urlToRedirectTo = CommonUtils.constructRedirectUrl(this.casServerLoginUrl,
                        getServiceParameterName(), modifiedServiceUrl, this.renew, this.gateway);

                logger.debug("redirecting to \"{}\"", urlToRedirectTo);
                this.authenticationRedirectStrategy.redirect(request, response, urlToRedirectTo);
        	}
        	
        }
        
    }

    public final void setRenew(final boolean renew) {
        this.renew = renew;
    }

    public final void setGateway(final boolean gateway) {
        this.gateway = gateway;
    }

    public final void setCasServerLoginUrl(final String casServerLoginUrl) {
        this.casServerLoginUrl = casServerLoginUrl;
    }

    public final void setGatewayStorage(final GatewayResolver gatewayStorage) {
        this.gatewayStorage = gatewayStorage;
    }
        
    private boolean isRequestUrlExcluded(final HttpServletRequest request) {
        if (this.ignoreUrlPatternMatcherStrategyClass == null) {
            return false;
        }
        
        final StringBuffer urlBuffer = request.getRequestURL();
        if (request.getQueryString() != null) {
            urlBuffer.append("?").append(request.getQueryString());
        }
        final String requestUri = urlBuffer.toString();
        return this.ignoreUrlPatternMatcherStrategyClass.matches(requestUri);
    }
}
