void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    // Time varying pixel color
    vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));

    
    
    float coef = iResolution.x / iResolution.y;
    
    if (pow(uv.x - 0.5+0.25*sin(iTime),2.0) + pow(uv.y-0.5+0.25*cos(iTime),2.0) <= pow(0.25,2.0))
    {    
        uv.x *= coef;
        fragColor = vec4(44.0/255.0, 116.0/255.0, 131.0/255.0,1.0);
    }
    else 
    // Output to screen
    {
        
        fragColor = texture(iChannel0,uv);
    }
    float A =0.05 ;
    float V = 1.0;
    float Q = 3.0;
    if (uv.y < 0.5 + A * sin( V * iTime + uv.x * Q ))
         fragColor = vec4(1.0,.0,.0,1.0);
    else if  (uv.y < 0.6 + A * sin( V * iTime + uv.x * Q ))
         fragColor = vec4(.0,1.0,.0,1.0);
    else if (uv.y < 0.7 + A * sin( V * iTime + uv.x * Q ))
         fragColor = vec4(1.0,1.0,.0,1.0);
    
    
}
