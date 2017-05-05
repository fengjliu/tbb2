
Shader "XuanQu/Charactor/Cloth-Alpha" {

Properties {
	_MainTex ("Base", 2D) = "grey" {}
	_MainTexAphle ("Base (RGB)", 2D) = "white" {}		
}

SubShader {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	LOD 200
	Fog {Mode Off}
	Blend SrcAlpha OneMinusSrcAlpha 
	ZWrite Off

	Pass {				

		CGPROGRAM
		
		#pragma vertex vert
		#pragma fragment frag
		
		#include "UnityCG.cginc"
		
		uniform half4 _MainTex_ST;
		uniform sampler2D _MainTex;
		uniform sampler2D _MainTexAphle;
		uniform fixed _SelfIllumination;
		fixed _Cutoff;
		
		struct v2f
		{
			half4 pos : POSITION;
			half2 uv : TEXCOORD0;
		};
		
		v2f vert (appdata_base v)
		{
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);	
			o.uv.xy = TRANSFORM_TEX(v.texcoord,_MainTex);
			
			return o; 
		}
		
		half4 frag (v2f i) : COLOR 
		{
			fixed4 tex = tex2D(_MainTex, i.uv.xy);
			fixed4 a = tex2D(_MainTexAphle, i.uv.xy);			
			tex.a = a.r;

			return tex;
		}
		
		ENDCG
	}
}

Fallback "VertexLit"
}
