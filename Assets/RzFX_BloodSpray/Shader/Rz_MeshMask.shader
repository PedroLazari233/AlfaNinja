// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RyanShader/Rz_MeshMask"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTex("MainTex", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_Emission("Emission", Range( 0 , 1)) = 0
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Roughness("Roughness", Range( 0 , 1)) = 0
		_T_BloodNoise_01_normal("T_BloodNoise_01_normal", 2D) = "white" {}
		_NormalValue("NormalValue", Float) = 1
		_FlowSpeed("FlowSpeed", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float2 uv2_texcoord2;
		};

		uniform sampler2D _T_BloodNoise_01_normal;
		uniform float _FlowSpeed;
		uniform float _NormalValue;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float _Emission;
		uniform float _Metallic;
		uniform float _Roughness;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime35 = _Time.y * _FlowSpeed;
			float2 panner10 = ( mulTime35 * float2( 0,-0.2 ) + i.uv_texcoord);
			float3 appendResult25 = (float3(_NormalValue , _NormalValue , 1.0));
			o.Normal = ( tex2D( _T_BloodNoise_01_normal, panner10 ) * float4( appendResult25 , 0.0 ) ).rgb;
			float4 tex2DNode5 = tex2D( _MainTex, panner10 );
			float4 temp_output_12_0 = ( _Color * ( ( tex2DNode5.a + 1.0 ) * 0.5 ) * i.vertexColor );
			o.Albedo = temp_output_12_0.rgb;
			o.Emission = ( temp_output_12_0 * _Emission ).rgb;
			o.Metallic = ( _Metallic * tex2DNode5.a );
			o.Smoothness = ( _Roughness * tex2DNode5.a );
			o.Alpha = 1;
			clip( step( ( ( 1.0 - i.uv2_texcoord2.x ) * 1.01 ) , ( ( ( i.uv_texcoord.y * tex2DNode5.a ) + tex2DNode5.a ) / 2.0 ) ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16200
1921;-16;1918;1016;1922.68;467.6551;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;36;-1734.48,412.7945;Float;False;Property;_FlowSpeed;FlowSpeed;8;0;Create;True;0;0;False;0;1;2.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1621.7,281.3999;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;35;-1560.48,417.7945;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;10;-1344.4,281.0999;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-0.2;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;9;-1416.099,68.30058;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;489b964dfc3eeef4dbb09df5facefd88;489b964dfc3eeef4dbb09df5facefd88;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;5;-1108.401,160.8001;Float;True;Property;_T_Noise_01;T_Noise_01;5;0;Create;True;0;0;False;0;489b964dfc3eeef4dbb09df5facefd88;489b964dfc3eeef4dbb09df5facefd88;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-708.16,383.832;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;30;-775.2546,480.8797;Float;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-1132.39,-6.040077;Float;False;Property;_NormalValue;NormalValue;7;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;14;-553.7001,486.701;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-522.4553,383.28;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;27;-788.39,166.1597;Float;False;ConstantBiasScale;-1;;1;63208df05c83e8e49a48ffbdce2e43a0;0;3;3;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;37;-757.9098,-213.3623;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1;-769,-11;Float;False;Property;_Color;Color;2;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-521.6003,284.0001;Float;False;Property;_Roughness;Roughness;5;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-380.4,486.001;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;33;-366.2548,383.7797;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-943.3903,-11.04008;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-518.1,109.3;Float;False;Property;_Emission;Emission;3;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;-1114.589,-215.6401;Float;True;Property;_T_BloodNoise_01_normal;T_BloodNoise_01_normal;6;0;Create;True;0;0;False;0;a123914785396034ca312926a7f4494c;a123914785396034ca312926a7f4494c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2;-518,184;Float;False;Property;_Metallic;Metallic;4;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-520,-6;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;6;-171.7999,413.3003;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-184,66;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-521.1902,-118.8401;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-184.1902,189.3599;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-187.0901,290.2599;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2,-2;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;RyanShader/Rz_MeshMask;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;True;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;35;0;36;0
WireConnection;10;0;11;0
WireConnection;10;1;35;0
WireConnection;5;0;9;0
WireConnection;5;1;10;0
WireConnection;34;0;11;2
WireConnection;34;1;5;4
WireConnection;14;0;30;1
WireConnection;32;0;34;0
WireConnection;32;1;5;4
WireConnection;27;3;5;4
WireConnection;8;0;14;0
WireConnection;33;0;32;0
WireConnection;25;0;23;0
WireConnection;25;1;23;0
WireConnection;22;1;10;0
WireConnection;12;0;1;0
WireConnection;12;1;27;0
WireConnection;12;2;37;0
WireConnection;6;0;8;0
WireConnection;6;1;33;0
WireConnection;13;0;12;0
WireConnection;13;1;4;0
WireConnection;26;0;22;0
WireConnection;26;1;25;0
WireConnection;20;0;2;0
WireConnection;20;1;5;4
WireConnection;21;0;3;0
WireConnection;21;1;5;4
WireConnection;0;0;12;0
WireConnection;0;1;26;0
WireConnection;0;2;13;0
WireConnection;0;3;20;0
WireConnection;0;4;21;0
WireConnection;0;10;6;0
ASEEND*/
//CHKSM=8EFA5A7F5C463D9709E579551467FB999CD896D0