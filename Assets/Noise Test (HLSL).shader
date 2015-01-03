﻿Shader "Custom/Noise Test (HLSL)"
{
    Properties
    {
        _Density("Density", Float) = 4
    }
    CGINCLUDE

#include "UnityCG.cginc"
#include "ClassicNoise3D.cginc"

float _Density;

v2f_img vert(appdata_base v)
{
    v2f_img o;
    o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
    o.uv = v.texcoord.xy * _Density;
    return o;
}

float4 frag(v2f_img i) : SV_Target 
{
    float2 c = i.uv;
    float w = 0.5;
    float s = 0.5;
    for (int i = 0; i < 6; i++)
    {
        s += cnoise(float3(c.x, c.y, _Time.y)) * w;
        c *= 2.0;
        w *= 0.5;
    }
    return float4(s);
}

    ENDCG
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma target 3.0
            #pragma glsl
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
        }
    }
}
