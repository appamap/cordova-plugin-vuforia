/*===============================================================================
Copyright (c) 2016 PTC Inc. All Rights Reserved.

Copyright (c) 2012-2015 Qualcomm Connected Experiences, Inc. All Rights Reserved.

Vuforia is a trademark of PTC Inc., registered in the United States and other 
countries.
===============================================================================*/

#include "SampleMath.h"

#include <math.h>
#include <stdlib.h>


namespace SampleMath
{
    Vuforia::Vec2F
    Vec2FSub(Vuforia::Vec2F v1, Vuforia::Vec2F v2)
    {
        Vuforia::Vec2F r;
        r.data[0] = v1.data[0] - v2.data[0];
        r.data[1] = v1.data[1] - v2.data[1];
        return r;
    }
    
    
    float
    Vec2FDist(Vuforia::Vec2F v1, Vuforia::Vec2F v2)
    {
        float dx = v1.data[0] - v2.data[0];
        float dy = v1.data[1] - v2.data[1];
        return sqrt(dx * dx + dy * dy);
    }
    
    
    Vuforia::Vec3F
    Vec3FAdd(Vuforia::Vec3F v1, Vuforia::Vec3F v2)
    {
        Vuforia::Vec3F r;
        r.data[0] = v1.data[0] + v2.data[0];
        r.data[1] = v1.data[1] + v2.data[1];
        r.data[2] = v1.data[2] + v2.data[2];
        return r;
    }
    
    
    Vuforia::Vec3F
    Vec3FSub(Vuforia::Vec3F v1, Vuforia::Vec3F v2)
    {
        Vuforia::Vec3F r;
        r.data[0] = v1.data[0] - v2.data[0];
        r.data[1] = v1.data[1] - v2.data[1];
        r.data[2] = v1.data[2] - v2.data[2];
        return r;
    }
    
    
    Vuforia::Vec3F
    Vec3FScale(Vuforia::Vec3F v, float s)
    {
        Vuforia::Vec3F r;
        r.data[0] = v.data[0] * s;
        r.data[1] = v.data[1] * s;
        r.data[2] = v.data[2] * s;
        return r;
    }
    
    
    float
    Vec3FDot(Vuforia::Vec3F v1, Vuforia::Vec3F v2)
    {
        return v1.data[0] * v2.data[0] + v1.data[1] * v2.data[1] + v1.data[2] * v2.data[2];
    }
    
    
    Vuforia::Vec3F
    Vec3FCross(Vuforia::Vec3F v1, Vuforia::Vec3F v2)
    {
        Vuforia::Vec3F r;
        r.data[0] = v1.data[1] * v2.data[2] - v1.data[2] * v2.data[1];
        r.data[1] = v1.data[2] * v2.data[0] - v1.data[0] * v2.data[2];
        r.data[2] = v1.data[0] * v2.data[1] - v1.data[1] * v2.data[0];
        return r;
    }
    
    
    Vuforia::Vec3F
    Vec3FNormalize(Vuforia::Vec3F v)
    {
        Vuforia::Vec3F r;
        
        float length = sqrt(v.data[0] * v.data[0] + v.data[1] * v.data[1] + v.data[2] * v.data[2]);
        if (length != 0.0f)
            length = 1.0f / length;
        
        r.data[0] = v.data[0] * length;
        r.data[1] = v.data[1] * length;
        r.data[2] = v.data[2] * length;
        
        return r;
    }
    
    
    Vuforia::Vec3F
    Vec3FTransform(Vuforia::Vec3F& v, Vuforia::Matrix44F& m)
    {
        Vuforia::Vec3F r;
        float lambda;
        lambda    = m.data[12] * v.data[0] +
        m.data[13] * v.data[1] +
        m.data[14] * v.data[2] +
        m.data[15];
        
        r.data[0] = m.data[0] * v.data[0] +
        m.data[1] * v.data[1] +
        m.data[2] * v.data[2] +
        m.data[3];
        r.data[1] = m.data[4] * v.data[0] +
        m.data[5] * v.data[1] +
        m.data[6] * v.data[2] +
        m.data[7];
        r.data[2] = m.data[8] * v.data[0] +
        m.data[9] * v.data[1] +
        m.data[10] * v.data[2] +
        m.data[11];
        
        r.data[0] /= lambda;
        r.data[1] /= lambda;
        r.data[2] /= lambda;
        
        return r;
    }
    
    
    Vuforia::Vec3F
    Vec3FTransformNormal(Vuforia::Vec3F& v, Vuforia::Matrix44F& m)
    {
        Vuforia::Vec3F r;
        
        r.data[0] = m.data[0] * v.data[0] +
        m.data[1] * v.data[1] +
        m.data[2] * v.data[2];
        r.data[1] = m.data[4] * v.data[0] +
        m.data[5] * v.data[1] +
        m.data[6] * v.data[2];
        r.data[2] = m.data[8] * v.data[0] +
        m.data[9] * v.data[1] +
        m.data[10] * v.data[2];
        
        return r;
    }
    
    
    Vuforia::Vec4F
    Vec4FTransform(Vuforia::Vec4F& v, Vuforia::Matrix44F& m)
    {
        Vuforia::Vec4F r;
        
        r.data[0] = m.data[0] * v.data[0] +
        m.data[1] * v.data[1] +
        m.data[2] * v.data[2] +
        m.data[3] * v.data[3];
        r.data[1] = m.data[4] * v.data[0] +
        m.data[5] * v.data[1] +
        m.data[6] * v.data[2] +
        m.data[7] * v.data[3];
        r.data[2] = m.data[8] * v.data[0] +
        m.data[9] * v.data[1] +
        m.data[10] * v.data[2] +
        m.data[11] * v.data[3];
        r.data[3] = m.data[12] * v.data[0] +
        m.data[13] * v.data[1] +
        m.data[14] * v.data[2] +
        m.data[15] * v.data[3];
        
        return r;
    }
    
    
    Vuforia::Vec4F
    Vec4FDiv(Vuforia::Vec4F v, float s)
    {
        Vuforia::Vec4F r;
        r.data[0] = v.data[0] / s;
        r.data[1] = v.data[1] / s;
        r.data[2] = v.data[2] / s;
        r.data[3] = v.data[3] / s;
        return r;
    }
    
    
    Vuforia::Matrix44F
    Matrix44FIdentity()
    {
        Vuforia::Matrix44F r;
        
        for (int i = 0; i < 16; i++)
            r.data[i] = 0.0f;
        
        r.data[0] = 1.0f;
        r.data[5] = 1.0f;
        r.data[10] = 1.0f;
        r.data[15] = 1.0f;
        
        return r;
    }
    
    
    Vuforia::Matrix44F
    Matrix44FTranspose(Vuforia::Matrix44F m)
    {
        Vuforia::Matrix44F r;
        for (int i = 0; i < 4; i++)
            for (int j = 0; j < 4; j++)
                r.data[i*4+j] = m.data[i+4*j];
        return r;
    }
    
    
    float
    Matrix44FDeterminate(Vuforia::Matrix44F& m)
    {
        return  m.data[12] * m.data[9] * m.data[6] * m.data[3] - m.data[8] * m.data[13] * m.data[6] * m.data[3] -
        m.data[12] * m.data[5] * m.data[10] * m.data[3] + m.data[4] * m.data[13] * m.data[10] * m.data[3] +
        m.data[8] * m.data[5] * m.data[14] * m.data[3] - m.data[4] * m.data[9] * m.data[14] * m.data[3] -
        m.data[12] * m.data[9] * m.data[2] * m.data[7] + m.data[8] * m.data[13] * m.data[2] * m.data[7] +
        m.data[12] * m.data[1] * m.data[10] * m.data[7] - m.data[0] * m.data[13] * m.data[10] * m.data[7] -
        m.data[8] * m.data[1] * m.data[14] * m.data[7] + m.data[0] * m.data[9] * m.data[14] * m.data[7] +
        m.data[12] * m.data[5] * m.data[2] * m.data[11] - m.data[4] * m.data[13] * m.data[2] * m.data[11] -
        m.data[12] * m.data[1] * m.data[6] * m.data[11] + m.data[0] * m.data[13] * m.data[6] * m.data[11] +
        m.data[4] * m.data[1] * m.data[14] * m.data[11] - m.data[0] * m.data[5] * m.data[14] * m.data[11] -
        m.data[8] * m.data[5] * m.data[2] * m.data[15] + m.data[4] * m.data[9] * m.data[2] * m.data[15] +
        m.data[8] * m.data[1] * m.data[6] * m.data[15] - m.data[0] * m.data[9] * m.data[6] * m.data[15] -
        m.data[4] * m.data[1] * m.data[10] * m.data[15] + m.data[0] * m.data[5] * m.data[10] * m.data[15] ;
    }
    
    
    Vuforia::Matrix44F
    Matrix44FInverse(Vuforia::Matrix44F& m)
    {
        Vuforia::Matrix44F r;
        
        float det = 1.0f / Matrix44FDeterminate(m);
        
        r.data[0]   = m.data[6]*m.data[11]*m.data[13] - m.data[7]*m.data[10]*m.data[13]
        + m.data[7]*m.data[9]*m.data[14] - m.data[5]*m.data[11]*m.data[14]
        - m.data[6]*m.data[9]*m.data[15] + m.data[5]*m.data[10]*m.data[15];
        
        r.data[4]   = m.data[3]*m.data[10]*m.data[13] - m.data[2]*m.data[11]*m.data[13]
        - m.data[3]*m.data[9]*m.data[14] + m.data[1]*m.data[11]*m.data[14]
        + m.data[2]*m.data[9]*m.data[15] - m.data[1]*m.data[10]*m.data[15];
        
        r.data[8]   = m.data[2]*m.data[7]*m.data[13] - m.data[3]*m.data[6]*m.data[13]
        + m.data[3]*m.data[5]*m.data[14] - m.data[1]*m.data[7]*m.data[14]
        - m.data[2]*m.data[5]*m.data[15] + m.data[1]*m.data[6]*m.data[15];
        
        r.data[12]  = m.data[3]*m.data[6]*m.data[9] - m.data[2]*m.data[7]*m.data[9]
        - m.data[3]*m.data[5]*m.data[10] + m.data[1]*m.data[7]*m.data[10]
        + m.data[2]*m.data[5]*m.data[11] - m.data[1]*m.data[6]*m.data[11];
        
        r.data[1]   = m.data[7]*m.data[10]*m.data[12] - m.data[6]*m.data[11]*m.data[12]
        - m.data[7]*m.data[8]*m.data[14] + m.data[4]*m.data[11]*m.data[14]
        + m.data[6]*m.data[8]*m.data[15] - m.data[4]*m.data[10]*m.data[15];
        
        r.data[5]   = m.data[2]*m.data[11]*m.data[12] - m.data[3]*m.data[10]*m.data[12]
        + m.data[3]*m.data[8]*m.data[14] - m.data[0]*m.data[11]*m.data[14]
        - m.data[2]*m.data[8]*m.data[15] + m.data[0]*m.data[10]*m.data[15];
        
        r.data[9]   = m.data[3]*m.data[6]*m.data[12] - m.data[2]*m.data[7]*m.data[12]
        - m.data[3]*m.data[4]*m.data[14] + m.data[0]*m.data[7]*m.data[14]
        + m.data[2]*m.data[4]*m.data[15] - m.data[0]*m.data[6]*m.data[15];
        
        r.data[13]  = m.data[2]*m.data[7]*m.data[8] - m.data[3]*m.data[6]*m.data[8]
        + m.data[3]*m.data[4]*m.data[10] - m.data[0]*m.data[7]*m.data[10]
        - m.data[2]*m.data[4]*m.data[11] + m.data[0]*m.data[6]*m.data[11];
        
        r.data[2]   = m.data[5]*m.data[11]*m.data[12] - m.data[7]*m.data[9]*m.data[12]
        + m.data[7]*m.data[8]*m.data[13] - m.data[4]*m.data[11]*m.data[13]
        - m.data[5]*m.data[8]*m.data[15] + m.data[4]*m.data[9]*m.data[15];
        
        r.data[6]   = m.data[3]*m.data[9]*m.data[12] - m.data[1]*m.data[11]*m.data[12]
        - m.data[3]*m.data[8]*m.data[13] + m.data[0]*m.data[11]*m.data[13]
        + m.data[1]*m.data[8]*m.data[15] - m.data[0]*m.data[9]*m.data[15];
        
        r.data[10]  = m.data[1]*m.data[7]*m.data[12] - m.data[3]*m.data[5]*m.data[12]
        + m.data[3]*m.data[4]*m.data[13] - m.data[0]*m.data[7]*m.data[13]
        - m.data[1]*m.data[4]*m.data[15] + m.data[0]*m.data[5]*m.data[15];
        
        r.data[14]  = m.data[3]*m.data[5]*m.data[8] - m.data[1]*m.data[7]*m.data[8]
        - m.data[3]*m.data[4]*m.data[9] + m.data[0]*m.data[7]*m.data[9]
        + m.data[1]*m.data[4]*m.data[11] - m.data[0]*m.data[5]*m.data[11];
        
        r.data[3]   = m.data[6]*m.data[9]*m.data[12] - m.data[5]*m.data[10]*m.data[12]
        - m.data[6]*m.data[8]*m.data[13] + m.data[4]*m.data[10]*m.data[13]
        + m.data[5]*m.data[8]*m.data[14] - m.data[4]*m.data[9]*m.data[14];
        
        r.data[7]  = m.data[1]*m.data[10]*m.data[12] - m.data[2]*m.data[9]*m.data[12]
        + m.data[2]*m.data[8]*m.data[13] - m.data[0]*m.data[10]*m.data[13]
        - m.data[1]*m.data[8]*m.data[14] + m.data[0]*m.data[9]*m.data[14];
        
        r.data[11]  = m.data[2]*m.data[5]*m.data[12] - m.data[1]*m.data[6]*m.data[12]
        - m.data[2]*m.data[4]*m.data[13] + m.data[0]*m.data[6]*m.data[13]
        + m.data[1]*m.data[4]*m.data[14] - m.data[0]*m.data[5]*m.data[14];
        
        r.data[15]  = m.data[1]*m.data[6]*m.data[8] - m.data[2]*m.data[5]*m.data[8]
        + m.data[2]*m.data[4]*m.data[9] - m.data[0]*m.data[6]*m.data[9]
        - m.data[1]*m.data[4]*m.data[10] + m.data[0]*m.data[5]*m.data[10];
        
        for (int i = 0; i < 16; i++)
            r.data[i] *= det;
        
        return r;
    }
    
    
    bool
    linePlaneIntersection(Vuforia::Vec3F lineStart, Vuforia::Vec3F lineEnd,
                          Vuforia::Vec3F pointOnPlane, Vuforia::Vec3F planeNormal,
                          Vuforia::Vec3F &intersection)
    {
        Vuforia::Vec3F lineDir = Vec3FSub(lineEnd, lineStart);
        lineDir = Vec3FNormalize(lineDir);
        
        Vuforia::Vec3F planeDir = Vec3FSub(pointOnPlane, lineStart);
        
        float n = Vec3FDot(planeNormal, planeDir);
        float d = Vec3FDot(planeNormal, lineDir);
        
        if (fabs(d) < 0.00001) {
            // Line is parallel to plane
            return false;
        }
        
        float dist = n / d;
        
        Vuforia::Vec3F offset = Vec3FScale(lineDir, dist);
        intersection = Vec3FAdd(lineStart, offset);
        
        return true;
    }
    
    
    void
    projectScreenPointToPlane(Vuforia::Matrix44F inverseProjMatrix, Vuforia::Matrix44F modelViewMatrix,
                              float screenWidth, float screenHeight,
                              Vuforia::Vec2F point, Vuforia::Vec3F planeCenter, Vuforia::Vec3F planeNormal,
                              Vuforia::Vec3F &intersection, Vuforia::Vec3F &lineStart, Vuforia::Vec3F &lineEnd)
    {
        // Window Coordinates to Normalized Device Coordinates
        Vuforia::VideoBackgroundConfig config = Vuforia::Renderer::getInstance().getVideoBackgroundConfig();
        
        float halfScreenWidth = screenWidth / 2.0f;
        float halfScreenHeight = screenHeight / 2.0f;
        
        float halfViewportWidth = config.mSize.data[0] / 2.0f;
        float halfViewportHeight = config.mSize.data[1] / 2.0f;
        
        float x = (point.data[0] - halfScreenWidth) / halfViewportWidth;
        float y = (point.data[1] - halfScreenHeight) / halfViewportHeight * -1;
        
        Vuforia::Vec4F ndcNear(x, y, -1, 1);
        Vuforia::Vec4F ndcFar(x, y, 1, 1);
        
        // Normalized Device Coordinates to Eye Coordinates
        Vuforia::Vec4F pointOnNearPlane = Vec4FTransform(ndcNear, inverseProjMatrix);
        Vuforia::Vec4F pointOnFarPlane = Vec4FTransform(ndcFar, inverseProjMatrix);
        pointOnNearPlane = Vec4FDiv(pointOnNearPlane, pointOnNearPlane.data[3]);
        pointOnFarPlane = Vec4FDiv(pointOnFarPlane, pointOnFarPlane.data[3]);
        
        // Eye Coordinates to Object Coordinates
        Vuforia::Matrix44F inverseModelViewMatrix = Matrix44FInverse(modelViewMatrix);
        
        Vuforia::Vec4F nearWorld = Vec4FTransform(pointOnNearPlane, inverseModelViewMatrix);
        Vuforia::Vec4F farWorld = Vec4FTransform(pointOnFarPlane, inverseModelViewMatrix);
        
        lineStart = Vuforia::Vec3F(nearWorld.data[0], nearWorld.data[1], nearWorld.data[2]);
        lineEnd = Vuforia::Vec3F(farWorld.data[0], farWorld.data[1], farWorld.data[2]);
        linePlaneIntersection(lineStart, lineEnd, planeCenter, planeNormal, intersection);
    }
}

