Shader "FxShader_py/py_additive(offset-rgb)_a" {
    Properties {
        _tex02_strong ("tex02_strong", Float ) = 1
        _colorRGBA ("color(RGBA)", Color) = (0.5,0.5,0.5,1)
        _tex01RGB_BV ("tex01(RGB)_B-V", 2D) = "white" {}
        _tex02_maskRGB_UVR ("tex02_mask(RGB)_UV-R", 2D) = "white" {}
        _tex01_color_strong ("tex01_color_strong", Float ) = 1
        _tex02_offset_u_1n ("tex02_offset_u_1/n", Float ) = 1
        _tex02_offset_v_1n ("tex02_offset_v_1/n", Float ) = 1
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        LOD 200
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float _tex02_strong;
            uniform float4 _colorRGBA;
            uniform sampler2D _tex01RGB_BV; uniform float4 _tex01RGB_BV_ST;
            uniform sampler2D _tex02_maskRGB_UVR; uniform float4 _tex02_maskRGB_UVR_ST;
            uniform float _tex01_color_strong;
            uniform float _tex02_offset_u_1n;
            uniform float _tex02_offset_v_1n;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {

                float node_9544 = 1.0;
                float2 node_3321 = (i.uv0+(float2(node_9544,i.vertexColor.b)*float2(node_9544,node_9544))*float2(1,1));
                float4 _tex01RGB_BV_var = tex2D(_tex01RGB_BV,TRANSFORM_TEX(node_3321, _tex01RGB_BV));
                float2 node_4899 = (i.uv0+(float2((ceil((i.vertexColor.r*_tex02_offset_u_1n))/_tex02_offset_u_1n),(ceil((i.vertexColor.g*_tex02_offset_v_1n))/_tex02_offset_v_1n))*float2(node_9544,node_9544))*float2(1,1));
                float4 _tex02_maskRGB_UVR_var = tex2D(_tex02_maskRGB_UVR,TRANSFORM_TEX(node_4899, _tex02_maskRGB_UVR));
                float3 node_1199 = (_tex02_strong*_tex02_maskRGB_UVR_var.rgb);
                float3 node_7151 = ((i.vertexColor.a*_colorRGBA.a)*node_1199);
                float3 emissive = (((_tex01_color_strong*_tex01RGB_BV_var.rgb)*_colorRGBA.rgb)*node_7151);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
