// MIT license applies
// created by Matti Kauppila

Shader "Examples/MattiKauppilaDistort"
{
	Properties
	{
		_NoiseMap ("Noise Map", 2D) = "white" {}
		_Color ("Color Tint", COLOR) = ( 0.0, 0.0, 0.0, 1.0 )
		_StrengthMap ("Distort strenght map", 2D) = "white" {}
		_DistortStrength ("Distort boost", float) = 1
		_CameraAngle("Camera Angle", Vector) = (0,0,0)
		_CameraPosition("Camera Position", Vector) = (0,0,0)
	}
	SubShader
	{

		Tags { "Queue" = "Transparent" }

		GrabPass
		{

		}

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct vertexData
			{
				float4 pos : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct fragmentData
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 screenuv : TEXCOORD1;
			};

			sampler2D _NoiseMap;
			sampler2D _GrabTexture;
			sampler2D _StrengthMap;
			float _DistortStrength;
			float4 _Color;
			float4 _CameraAngle;
			float4 _CameraPosition;

			fragmentData vert (vertexData v)
			{ 
				fragmentData o;
				o.pos = UnityObjectToClipPos(v.pos);
				o.uv = v.uv;
				float4 grabPos = ComputeGrabScreenPos(o.pos);
				o.screenuv = grabPos.xy / grabPos.w;
				return o;
			}

			fixed4 frag (fragmentData i) : SV_TARGET
			{
				float n = tex2D(_NoiseMap, i.uv);
				float x = tex2D(_StrengthMap, i.uv);
				float4 white = ( 1,1,1,1 );
				float4 color = white - _Color * x;
				float2 suv = i.screenuv + (2*n-1) * x * _DistortStrength;
				return tex2D(_GrabTexture, suv) * color;

			}

			ENDCG
		}
	}
}
