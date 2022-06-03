// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RyanShader/Rz_NoiseDissolve"
{
	Properties
	{
		_Color("Color", Color) = (1,0,0,1)
		_MainTex("MainTex", 2D) = "white" {}
		_Emission("Emission", Float) = 0
		_NormalValue("NormalValue", Float) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float2 uv2_texcoord2;
		};

		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _NormalValue;
		uniform float4 _Color;
		uniform float _Emission;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode2 = tex2D( _MainTex, uv_MainTex );
			float3 appendResult18 = (float3(( tex2DNode2.g * _NormalValue ) , ( tex2DNode2.b * _NormalValue ) , 1.0));
			o.Normal = appendResult18;
			float4 temp_output_10_0 = ( _Color * ( ( tex2DNode2.r + 0.2 ) * 0.833 ) * i.vertexColor );
			o.Albedo = temp_output_10_0.rgb;
			o.Emission = ( temp_output_10_0 * _Emission ).rgb;
			float temp_output_15_0 = 0.5;
			o.Metallic = temp_output_15_0;
			o.Smoothness = temp_output_15_0;
			float clampResult12 = clamp( i.uv2_texcoord2.x , 0.0 , 1.0 );
			o.Alpha = ( tex2DNode2.a * step( tex2DNode2.r , clampResult12 ) * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
1920;20;1906;999;1230.964;217.2475;1;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;1;-1179,158;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;1c97e3a01f0c852489b7a6d7d06e3f75;906ebebad1b2cce47ba4402a92d80e67;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;4;-781,351;Float;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-915,157;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;12;-544,349;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;-610,-188;Float;False;Property;_Color;Color;0;0;Create;True;0;0;False;0;1,0,0,1;0.8,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-766.964,536.7525;Float;False;Property;_NormalValue;NormalValue;3;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;16;-577.9644,128.2525;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;13;-630,3;Float;False;ConstantBiasScale;-1;;1;63208df05c83e8e49a48ffbdce2e43a0;0;3;3;FLOAT;0;False;1;FLOAT;0.2;False;2;FLOAT;0.833;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-375,-20;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-536.964,471.7525;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;14;-363,326;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-536.964,576.7525;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-384,128;Float;False;Property;_Emission;Emission;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;-372.964,515.7525;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-201.5057,155.2034;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-185,47;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-187,259;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2,-8;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;RyanShader/Rz_NoiseDissolve;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;0
WireConnection;12;0;4;1
WireConnection;13;3;2;1
WireConnection;10;0;7;0
WireConnection;10;1;13;0
WireConnection;10;2;16;0
WireConnection;19;0;2;2
WireConnection;19;1;17;0
WireConnection;14;0;2;1
WireConnection;14;1;12;0
WireConnection;20;0;2;3
WireConnection;20;1;17;0
WireConnection;18;0;19;0
WireConnection;18;1;20;0
WireConnection;8;0;10;0
WireConnection;8;1;9;0
WireConnection;11;0;2;4
WireConnection;11;1;14;0
WireConnection;11;2;16;4
WireConnection;0;0;10;0
WireConnection;0;1;18;0
WireConnection;0;2;8;0
WireConnection;0;3;15;0
WireConnection;0;4;15;0
WireConnection;0;9;11;0
ASEEND*/
//CHKSM=FA24A5D045F6C687A21FAEEA85F138C3C27E12B6