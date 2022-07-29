void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    vec3 light_source = vec3(10.0, 0.0  +  10.0 * sin(iTime), 10.0);
    float distance_to_plate = 10.0;
    vec2 plateReso = vec2 (32.0, 18.0);
    vec3 luch_zren = vec3(distance_to_plate , (uv.x - 0.5)*plateReso.x ,
        (uv.y - 0.5) * plateReso.y);
    vec3 sphere_center = vec3 (12.0 ,
    .0+ 2.0*sin(iTime),.0+2.0*cos(iTime));
    float s_R = 5.0;
    float a = dot(luch_zren, luch_zren);
    float b = -2.0 * dot (sphere_center, luch_zren);
    float c = dot(sphere_center,sphere_center) - s_R*s_R;
    float D = b*b - 4.0*a*c;
    if (D>=0.0 )  
    {
        fragColor = vec4(.3,.0,.0,1.0);
        float t0 = (-b-sqrt(D))/(2.0*a);
        vec3 onSphere = t0*luch_zren;
        vec3 n = onSphere - sphere_center;
        vec3 q = light_source - onSphere;
        n = normalize(n);
        q = normalize(q);
        float diff = dot(n,q);
        if (diff > 0.0) {
            fragColor += diff * vec4(.5,.0,.0,.0);
        }
        vec3 v = normalize(onSphere);
        vec3 r = reflect(v,n);
  
        if (dot(r,q) > 0.0) {
            float spec = pow (dot(r,q),10.0);
            fragColor += spec * vec4(.3,.3,.3,.0);
        }
        
        
    }
    else {
        
        float h = -7.0;
        float t1 = h/luch_zren.z;
        if (t1>0.0) {
            vec3 onPlate = t1*luch_zren;
            vec3 n_pol = vec3 (.0 , .0, 1.0);
            vec3 to_light = normalize ( light_source - onPlate);
            float diff = dot (to_light , n_pol);
            vec4 col_pol = vec4(.3 , .3 , .3, 1.0);
            fragColor = col_pol;
            if (diff > 0.0) {
                fragColor += 1.3*diff * col_pol;
            }
        }
        else fragColor = vec4(1.0,1.0,1.0,1.0);
   }
  
}
