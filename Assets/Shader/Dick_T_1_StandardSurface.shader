Shader "Dick/Tutorial/1_StandardSurface" {

	/*属性声明： 暴露给设计师调整的参数(属性)*/
	Properties {
		//变量的声明方式为:*变量名称("Inspector 显示名称",类型)=缺省值*
		//这里等号和缺省值可以没有

		//颜色值，显示为一个颜色选择框
		_Color ("Color", Color) = (1,1,1,1)  
		//2D 贴图，"white"表示内置的白色贴图,在inspector中显示为一个纹理贴图框
		_MainTex ("Albedo (RGB)", 2D) = "white" {} 
		//浮点数，取值范围0-1，默认0.5，在inspector中显示为一个滑条
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		//浮点数，取值范围0-1，默认0
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}

	SubShader {

		//subshader 层级的标签
		Tags { "RenderType"="Opaque" }

		/*LOD Shader Level of Detail
		当此处的值200小于系统设定的一个值时，该shader在有效
		默认情况下系统设定的值为无限大的值，所有shader无论LOD都可以通过该条件
		*/
		LOD 200 
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0


		/*在shader正文里注册属性代码块中声明的变量，名称保持一致*/
		sampler2D _MainTex;  //2D贴图变量，类型为 2D 贴图采样器
		half _Glossiness; //光泽度，类型为16位浮点数
		half _Metallic; //表面光滑度也就是表现为金属质感的程度，类型为16位浮点数
		fixed4 _Color; //RGBA颜色值，类型为4个8位浮点数组成的结构


		/*surface shader 的输入结构*/
		struct Input {
			float2 uv_MainTex; //贴图的uv坐标，类型为2个32为浮点数结构
		};

		

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
