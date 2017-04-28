/*===============================================================================
Copyright (c) 2016 PTC Inc. All Rights Reserved.

Copyright (c) 2012-2015 Qualcomm Connected Experiences, Inc. All Rights Reserved.

Vuforia is a trademark of PTC Inc., registered in the United States and other 
countries.
===============================================================================*/


#ifndef _VUFORIA_SAMPLEMATH_H_
#define _VUFORIA_SAMPLEMATH_H_

// Includes:
#include <Vuforia/Tool.h>
#include <Vuforia/VideoBackgroundConfig.h>
#include <Vuforia/Renderer.h>

/// A set of utility math functions used by the Vuforia SDK samples.
namespace SampleMath
{
    Vuforia::Vec2F Vec2FSub(Vuforia::Vec2F v1, Vuforia::Vec2F v2);
    
    float Vec2FDist(Vuforia::Vec2F v1, Vuforia::Vec2F v2);
    
    Vuforia::Vec3F Vec3FAdd(Vuforia::Vec3F v1, Vuforia::Vec3F v2);
    
    Vuforia::Vec3F Vec3FSub(Vuforia::Vec3F v1, Vuforia::Vec3F v2);
    
    Vuforia::Vec3F Vec3FScale(Vuforia::Vec3F v, float s);
    
    float Vec3FDot(Vuforia::Vec3F v1, Vuforia::Vec3F v2);
    
    Vuforia::Vec3F Vec3FCross(Vuforia::Vec3F v1, Vuforia::Vec3F v2);
    
    Vuforia::Vec3F Vec3FNormalize(Vuforia::Vec3F v);
    
    Vuforia::Vec3F Vec3FTransform(Vuforia::Vec3F& v, Vuforia::Matrix44F& m);
    
    Vuforia::Vec3F Vec3FTransformNormal(Vuforia::Vec3F& v, Vuforia::Matrix44F& m);
    
    Vuforia::Vec4F Vec4FTransform(Vuforia::Vec4F& v, Vuforia::Matrix44F& m);
    
    Vuforia::Vec4F Vec4FDiv(Vuforia::Vec4F v1, float s);

    Vuforia::Matrix44F Matrix44FIdentity();
    
    Vuforia::Matrix44F Matrix44FTranspose(Vuforia::Matrix44F m);
    
    float Matrix44FDeterminate(Vuforia::Matrix44F& m);
    
    Vuforia::Matrix44F Matrix44FInverse(Vuforia::Matrix44F& m);

    bool linePlaneIntersection(Vuforia::Vec3F lineStart, Vuforia::Vec3F lineEnd,
                      Vuforia::Vec3F pointOnPlane, Vuforia::Vec3F planeNormal,
                      Vuforia::Vec3F &intersection);
                      
    void projectScreenPointToPlane(Vuforia::Matrix44F inverseProjMatrix, Vuforia::Matrix44F modelViewMatrix,
                                          float screenWidth, float screenHeight, 
                                          Vuforia::Vec2F point, Vuforia::Vec3F planeCenter, Vuforia::Vec3F planeNormal,
                                          Vuforia::Vec3F &intersection, Vuforia::Vec3F &lineStart, Vuforia::Vec3F &lineEnd);
};

#endif // _VUFORIA_SAMPLEMATH_H_
