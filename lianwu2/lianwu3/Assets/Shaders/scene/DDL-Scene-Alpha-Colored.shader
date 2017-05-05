Shader "DDL/Scene/Alpha-Colored"
{
	Properties
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_AlphaTex ("Alpha (A)",2D ) = "white" {}
		_Color ("Main Color", Color) = (1,1,1,1)
	}

	SubShader
	{
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 100
		Fog {Mode Off}
		ZWrite Off
		
CGPROGRAM
#pragma surface surf Lambert noforwardadd alpha

sampler2D _MainTex;
sampler2D _AlphaTex;
float4 _Color;

struct Input {
	float2 uv_MainTex;
};


float4 _DDL_Global_Add_Color;

void surf (Input IN, inout SurfaceOutput o) {
	fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
	fixed4 texaphla = tex2D(_AlphaTex, IN.uv_MainTex);
	o.Albedo = tex.rgb*_DDL_Global_Add_Color.rgb * _Color.rgb;
	o.Alpha = texaphla.r*_DDL_Global_Add_Color.a * _Color.a;
}
ENDCG

	}
Fallback "Diffuse"
}